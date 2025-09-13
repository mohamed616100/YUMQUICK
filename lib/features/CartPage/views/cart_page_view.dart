import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shimmer/shimmer.dart';
import 'package:yumquick/core/db_helper/CartDBHelper.dart';
import 'package:yumquick/core/helper/my_navgetor.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/App_icons.dart';
import 'package:yumquick/core/utils/app_paddings.dart';
import 'package:yumquick/core/widgets/Base_body.dart';
import 'package:yumquick/core/widgets/Custom_appbar.dart';
import 'package:yumquick/features/confirm_checkout/view/confirm_checkout_view.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [];
  bool isLoading = true;
  double subtotal = 0.0;
  double taxAndFees = 5.0; // Fixed tax and fees
  double delivery = 3.0; // Fixed delivery cost

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    setState(() {
      isLoading = true;
    });

    try {
      final items = await CartDBHelper.getCartItems();
      final total = await CartDBHelper.getTotalPrice();

      if (mounted) {
        setState(() {
          cartItems = items;
          subtotal = total;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _updateQuantity(int id, int newQuantity) async {
    await CartDBHelper.updateQuantity(id, newQuantity);
    _loadCartItems(); // Reload to update UI
  }

  Future<void> _removeItem(int id) async {
    await CartDBHelper.removeFromCart(id);
    _loadCartItems(); // Reload to update UI

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Item removed from cart",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  double get totalPrice => subtotal + taxAndFees + delivery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.primarycolor,
      body: BaseBody(
        height: 131.h,
        childcontiner: CustomAppbar(
          title: "Cart",
          icon: AppIcons.BackiconArrow,
          onTap: () => MyNavigator.goBack(context),
        ),
        body: isLoading
            ? Center(
          child: CircularProgressIndicator(
            color: Appcolors.secondarycolor,
          ),
        )
            : cartItems.isEmpty
            ? _buildEmptyCart()
            : _buildCartContent(),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100.sp,
            color: Colors.grey,
          ),
          SizedBox(height: 20.h),
          Text(
            "Your cart is empty",
            style: GoogleFonts.leagueSpartan(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            "Add some delicious items to get started!",
            style: GoogleFonts.leagueSpartan(
              fontSize: 16.sp,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent() {
    return Padding(
      padding: AppPaddings.Appbarhorizontalsymatric,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Text(
            "You have ${cartItems.length} items in the cart",
            style: GoogleFonts.leagueSpartan(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return _buildCartItem(item);
              },
            ),
          ),
          _buildOrderSummary(),
          SizedBox(height: 20.h),
          Center(
            child: GestureDetector(
              onTap: () {
                // Navigate to Confirm Order page
                MyNavigator.goTo(context, ConfirmOrderPage(
                  cartItems: cartItems,
                  subtotal: subtotal,
                  taxAndFees: taxAndFees,
                  delivery: delivery,
                  onOrderPlaced: () {
                    _loadCartItems();
                  }
                    )
                    ,type: NavigatorType.push);
              },
              child: Container(
                width: 200.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Appcolors.secondarycolor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Text(
                    'Checkout',
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: CachedNetworkImage(
              imageUrl: item['imagePath'] ?? '',
              width: 70.w,
              height: 70.h,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 70.w,
                  height: 70.h,
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: 70.w,
                height: 70.h,
                color: Colors.grey.shade200,
                child: Icon(
                  Icons.fastfood,
                  size: 30.sp,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(width: 15.w),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Text(
                      '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Appcolors.secondarycolor,
                      ),
                    ),
                    if (item['rating'] != null) ...[
                      SizedBox(width: 10.w),
                      Icon(
                        Icons.star,
                        size: 14.sp,
                        color: Colors.amber,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        item['rating'].toStringAsFixed(1),
                        style: GoogleFonts.leagueSpartan(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // Quantity Controls
          Column(
            children: [
              // Remove button
              GestureDetector(
                onTap: () => _removeItem(item['id']),
                child: Container(
                  width: 25.w,
                  height: 25.h,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 15.sp,
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              // Quantity controls
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (item['quantity'] > 1) {
                        _updateQuantity(item['id'], item['quantity'] - 1);
                      }
                    },
                    child: Container(
                      width: 25.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        color: item['quantity'] == 1
                            ? const Color(0xffFFDECF)
                            : Appcolors.secondarycolor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.remove,
                        size: 15.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      item['quantity'].toString(),
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      _updateQuantity(item['id'], item['quantity'] + 1);
                    },
                    child: Container(
                      width: 25.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        color: Appcolors.secondarycolor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        size: 15.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSummaryRow("Subtotal", "\$${subtotal.toStringAsFixed(2)}"),
          SizedBox(height: 10.h),
          _buildSummaryRow("Tax and Fees", "\$${taxAndFees.toStringAsFixed(2)}"),
          SizedBox(height: 10.h),
          _buildSummaryRow("Delivery", "\$${delivery.toStringAsFixed(2)}"),
          Divider(
            color: Colors.grey.shade300,
            thickness: 1,
            height: 25.h,
          ),
          _buildSummaryRow(
            "Total",
            "\$${totalPrice.toStringAsFixed(2)}",
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.leagueSpartan(
            fontSize: isTotal ? 18.sp : 16.sp,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.leagueSpartan(
            fontSize: isTotal ? 18.sp : 16.sp,
            fontWeight: FontWeight.bold,
            color: isTotal ? Appcolors.secondarycolor : Colors.black,
          ),
        ),
      ],
    );
  }
}