import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:yumquick/core/helper/my_navgetor.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/App_icons.dart';
import 'package:yumquick/core/utils/app_paddings.dart';
import 'package:yumquick/core/widgets/Base_body.dart';
import 'package:yumquick/core/widgets/Custom_appbar.dart';
import 'package:yumquick/core/widgets/Custom_bottom.dart';
import 'package:yumquick/features/MyOrders/data/models/OrderResponse.dart';
import 'package:yumquick/features/MyOrders/manager/cubit_canceld/canceld_state.dart';
import 'package:yumquick/features/MyOrders/manager/cubit_canceld/cubit_canceld.dart';
import 'package:yumquick/features/OrderDetails/Views/widgets/card_detailes.dart';


class Orderdetails extends StatelessWidget {
  const Orderdetails({
    super.key,
    required this.detiles,
    required this.order,
  });

  final List<Items> detiles;
  final Active order;

  String formatOrderDate(String dateString) {
    try {
      DateTime dateTime = HttpDate.parse(dateString).toLocal();
      String day = dateTime.day.toString();
      String month = DateFormat('MMM').format(dateTime);
      String time = DateFormat('hh:mm a').format(dateTime).toLowerCase();
      return '$day $month, $time';
    } catch (e) {
      return dateString;
    }
  }

  Widget _buildPriceRow(String title, String value,
      {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: GoogleFonts.leagueSpartan(
                fontSize: isTotal ? 18.sp : 16.sp,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              )),
          Text(value,
              style: GoogleFonts.leagueSpartan(
                fontSize: isTotal ? 18.sp : 16.sp,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.primarycolor,
      body: BaseBody(
        height: 129.h,
        childcontiner: Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: CustomAppbar(
              onTap: () => MyNavigator.goBack(context),
              title: 'Order Details',
              icon: AppIcons.BackiconArrow),
        ),
        body: Padding(
          padding: AppPaddings.Appbarhorizontalsymatric,
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order No. 0054752',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          )),
                      SizedBox(height: 8.h),
                      Text(formatOrderDate(order.orderDate ?? ''),
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey)),
                    ],
                  ),
                  Text('Active',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Appcolors.secondarycolor,
                      )),
                ],
              ),
              SizedBox(height: 20.h),

              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return CardDetailes(detiles: detiles[index]);
                  },
                  itemCount: detiles.length,
                ),
              ),

              Divider(thickness: 1, color: Colors.grey[300]),
              SizedBox(height: 10.h),


              _buildPriceRow('Subtotal', '\$${order.subtotal}'),
              _buildPriceRow('Tax and Fees', '\$5.00'),
              _buildPriceRow('Delivery', '\$3.00'),
              Divider(thickness: 1, color: Colors.grey[300]),
              _buildPriceRow('Total', '\$${order.total}', isTotal: true),

              SizedBox(height: 20.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocConsumer<CanceldCubit, CanceldState>(
                    listener: (context, state) {
                      if (state is CanceldSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.canceld.message!),
                              duration: const Duration(seconds: 2),)
                        );
                        Navigator.pop(context);
                      } else if (state is CanceldError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                            )
                        );
                      }

                    },
                    builder: (context, state) {
                      return CustomBottom(
                          onTap: () {
                            CanceldCubit.get(context).CaneldOrder(id:order.id!);
                          },
                          width: 107.w,
                          height: 26.h,
                          backgroundColor: Appcolors.secondarycolor,
                          reduis: 100.r,
                          text: 'Cancel Order',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          letterspacing: 0,
                          lineheight: 0);
                    },
                  ),
                  SizedBox(width: 15.w),
                  CustomBottom(
                    onTap: () {},
                    width: 107.w,
                    height: 26.h,
                    backgroundColor: Color(0xffFFDECF),
                    reduis: 100.r,
                    text: 'Track Driver',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    letterspacing: 0,
                    lineheight: 0,
                    colortext: Appcolors.secondarycolor,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
