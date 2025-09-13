import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yumquick/core/db_helper/CartDBHelper.dart';
import 'package:yumquick/core/helper/my_navgetor.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/App_icons.dart';
import 'package:yumquick/core/widgets/Base_body.dart';
import 'package:yumquick/core/widgets/Custom_appbar.dart';
import 'package:yumquick/features/confirm_checkout/manager/place_order_cubit.dart';
import 'package:yumquick/features/confirm_checkout/manager/placeorderstate.dart';
import 'package:yumquick/features/confirm_checkout/view/widgets/order_summary.dart';
import 'package:yumquick/features/confirm_checkout/view/widgets/orders_item.dart';
import 'package:yumquick/features/confirm_checkout/view/widgets/shipping_address.dart';

class ConfirmOrderPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final double subtotal;
  final double taxAndFees;
  final double delivery;
  final VoidCallback? onOrderPlaced;

  const ConfirmOrderPage({
    super.key,
    required this.cartItems,
    required this.subtotal,
    this.taxAndFees = 5.0,
    this.delivery = 3.0,
    this.onOrderPlaced,
  });

  @override
  State<ConfirmOrderPage> createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  String shippingAddress = "778 Locust View Drive Oakland, CA";

  double get subtotal => widget.subtotal;
  double get taxAndFees => widget.taxAndFees;
  double get delivery => widget.delivery;
  List<Map<String, dynamic>> get cartItems => widget.cartItems;
  double get totalPrice => subtotal + taxAndFees + delivery;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlaceOrderCubit(),
      child: Scaffold(
        backgroundColor: Appcolors.primarycolor,
        body: BaseBody(
          height: 131.h,
          childcontiner: CustomAppbar(
            title: "Confirm Order",
            icon: AppIcons.BackiconArrow,
            onTap: () => MyNavigator.goBack(context),
          ),
          body: cartItems.isEmpty
              ? Center(
            child: Text(
              "No items to confirm",
              style: GoogleFonts.leagueSpartan(
                fontSize: 18.sp,
                color: Colors.grey,
              ),
            ),
          )
              : _buildConfirmOrderContent(),
        ),
      ),
    );
  }

  Widget _buildConfirmOrderContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),


          ShippingAddressWidget(
            shippingAddress: shippingAddress,
            onAddressChanged: (value) {
              setState(() {
                shippingAddress = value;
              });
            },
          ),

          SizedBox(height: 25.h),

          Text(
            "Order Summary",
            style: GoogleFonts.leagueSpartan(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 15.h),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...cartItems.map((item) => OrderItemWidget(item: item)),
                  SizedBox(height: 20.h),

                  OrderSummaryWidget(
                    subtotal: subtotal,
                    taxAndFees: taxAndFees,
                    delivery: delivery,
                    totalPrice: totalPrice,
                  ),

                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),


          _buildPlaceOrderButton(),

          SizedBox(height: 30.h),
        ],
      ),
    );
  }

  Widget _buildPlaceOrderButton() {
    return Center(
      child: BlocConsumer<PlaceOrderCubit, PlaceOrderState>(
        listener: (context, state) async {
          if (state is PlaceOrderSuccess) {
            await CartDBHelper.clearCart();
            widget.onOrderPlaced?.call();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(" Order placed successfully"),
                backgroundColor: Colors.green,
              ),
            );

            Navigator.of(context).popUntil((route) => route.isFirst);
          } else if (state is PlaceOrderFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("❌ ${state.message}"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is PlaceOrderLoading;

          return GestureDetector(
            onTap: isLoading
                ? null
                : () {
              context.read<PlaceOrderCubit>().placeOrder(cartItems);
            },
            child: Container(
              width: 200.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: isLoading
                    ? Appcolors.secondarycolor.withOpacity(0.7)
                    : Appcolors.secondarycolor,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Center(
                child: isLoading
                    ? SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                    : Text(
                  'Place Order',
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
