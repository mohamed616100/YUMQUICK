import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shimmer/shimmer.dart';
import 'package:yumquick/core/db_helper/CartDBHelper.dart';
import 'package:yumquick/core/db_helper/ProductDBHelper.dart';
import 'package:yumquick/core/helper/my_navgetor.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/App_icons.dart';
import 'package:yumquick/core/utils/app_paddings.dart';
import 'package:yumquick/core/widgets/Base_body.dart';
import 'package:yumquick/core/widgets/Custom_appbar.dart';
import 'package:yumquick/core/widgets/custom_svg.dart';
import 'package:yumquick/features/Home/data/models/Top_Rated_Product.dart';
import 'package:yumquick/features/Home/data/models/best_seller_model.dart';


class ItemView extends StatefulWidget {
  const ItemView({super.key, this.bestSellerProducts, this.data});
  final BestSellerProducts? bestSellerProducts;
  final Products? data;


  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  bool isSaved = false;
  int quantity = 1;
  bool isAddingToCart = false; // For loading state

  @override
  void initState() {
    _checkIfSaved();
    super.initState();
  }

  Future<void> _checkIfSaved() async {
    final products = await ProductDBHelper.getProducts();
    final exists = products.any((p) => p['name'] == widget.data!.name);
    if (mounted) {
      setState(() {
        isSaved = exists;
      });
    }
  }

  Future<void> _toggleSave() async {
    if (isSaved) {
      await ProductDBHelper.deleteProduct(widget.data!.id?? 0);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Product removed",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      await ProductDBHelper.insertProduct(widget.data!);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Product saved",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );
    }

    if (mounted) {
      setState(() {
        isSaved = !isSaved;
      });
    }
  }

  // Add to cart function
  Future<void> _addToCart() async {
    if (isAddingToCart) return; // Prevent multiple taps

    setState(() {
      isAddingToCart = true;
    });

    try {
      // Use the Products object if available, otherwise use BestSellerProducts
      if (widget.data != null) {
        await CartDBHelper.addProductToCart(widget.data!, quantity);
      } else if (widget.bestSellerProducts != null) {
        // Convert BestSellerProducts to Products-like data
        await CartDBHelper.addToCart(
          id: widget.bestSellerProducts!.id ?? 0,
          name: widget.bestSellerProducts!.name ?? "No Name",
          price: widget.bestSellerProducts!.price ?? 0.0,
          imagePath: widget.bestSellerProducts!.imagePath,
          description: widget.bestSellerProducts!.description,
          quantity: quantity,
        );
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                quantity > 1
                    ? "$quantity items added to cart!"
                    : "Item added to cart!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          backgroundColor: Appcolors.secondarycolor,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      );

      // Reset quantity to 1 after adding
      setState(() {
        quantity = 1;
      });

    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Failed to add item to cart",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isAddingToCart = false;
        });
      }
    }
  }

  String get productName =>
      widget.bestSellerProducts?.name ?? widget.data?.name ?? "No Name";

  String get productImage =>
      widget.bestSellerProducts?.imagePath ?? widget.data?.imagePath ?? "";

  String get productDescription =>
      widget.bestSellerProducts?.description ??
          widget.data?.description ??
          "No Description";

  double get productPrice =>
      widget.bestSellerProducts?.price ?? widget.data?.price ?? 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.primarycolor,
      body: BaseBody(
        height: 131.h,
        childcontiner: CustomAppbar(
          title: productName,
          icon: AppIcons.BackiconArrow,
          onTap: () => MyNavigator.goBack(context),
          iconButton: IconButton(
            padding: EdgeInsets.only(right:20.w ),
            onPressed: () {
              _toggleSave();
            },
            icon: Container(
              alignment: Alignment.center,
              width: 30.w,
              height: 30.h,
              decoration: BoxDecoration(
                color: Appcolors.textcolorwhite,
                shape: BoxShape.circle,
              ),
              child: CustomSvg(
                path: AppIcons.fevicon,
                width: 8.w,
                height: 13.h,
                color: isSaved ? Colors.red : Colors.grey,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: AppPaddings.Appbarhorizontalsymatric,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 34.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(36.r),
                child: CachedNetworkImage(
                  imageUrl: productImage,
                  width: 339.w,
                  height: 229.h,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 339.w,
                      height: 229.h,
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 339.w,
                    height: 229.h,
                    color: Colors.grey.shade200,
                    child: Icon(
                      Icons.broken_image,
                      size: 40.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 34.h),
              Row(
                children: [
                  Text(
                    '\$$productPrice',
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Appcolors.secondarycolor,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      if (quantity > 1) {
                        setState(() {
                          quantity--;
                        });
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 21.w,
                      height: 21.h,
                      decoration: BoxDecoration(
                        color: quantity == 1
                            ? const Color(0xffFFDECF)
                            : Appcolors.secondarycolor,
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        width: 10.w,
                        height: 1.h,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    quantity.toString(),
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 21.w,
                      height: 21.h,
                      decoration: BoxDecoration(
                        color: Appcolors.secondarycolor,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '+',
                        style: TextStyle(
                          color: Appcolors.textcolorwhite,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Divider(
                color: const Color(0xffFFD8C7),
                thickness: 2,
                height: 20,
              ),
              SizedBox(height: 18.h),
              Text(
                productDescription,
                style: GoogleFonts.leagueSpartan(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 63.h),
              Center(
                child: GestureDetector(
                  onTap: isAddingToCart ? null : _addToCart,
                  child: Container(
                    width: 180.w,
                    height: 33.h,
                    decoration: BoxDecoration(
                      color: isAddingToCart
                          ? Appcolors.secondarycolor.withOpacity(0.7)
                          : Appcolors.secondarycolor,
                      borderRadius: BorderRadius.circular(45.r),
                    ),
                    child: Center(
                      child: isAddingToCart
                          ? SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Appcolors.textcolorwhite,
                          ),
                        ),
                      )
                          : Text(
                        'Add to Cart',
                        style: GoogleFonts.leagueSpartan(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: Appcolors.textcolorwhite,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}