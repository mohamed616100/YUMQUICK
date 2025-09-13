// features/MyOrders/view/widgets/order_card_cancelled.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/features/MyOrders/data/models/OrderResponse.dart';


class OrderCardCancelled extends StatelessWidget {
  final Canceled order;
  final Items items;
  const OrderCardCancelled({super.key, required this.order, required this.items});
  String formatOrderDate(String dateString) {
    try {
      DateTime dateTime = HttpDate.parse(dateString);
      dateTime = dateTime.toLocal();

      String day = dateTime.day.toString();
      String month = DateFormat('MMM').format(dateTime);
      String time = DateFormat('hh:mm a').format(dateTime).toLowerCase();

      return '$day $month, $time';
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: Appcolors.secondarycolor,
          thickness: 2,
          height: 1.h,
        ),
        SizedBox(height: 15.h),
        Row(
          children: [
            Container(
              height: 108.h,
              width: 71.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    items.imagePath!
                  ),
                ),
              ),
            ),
            SizedBox(width: 15.w),


            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    items.name ?? 'Unknown Item',
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    formatOrderDate(order.orderDate!),
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${(order.total ?? 0).toStringAsFixed(2)}',
                        style: GoogleFonts.leagueSpartan(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Appcolors.secondarycolor,
                        ),
                      ),
                      Text(
                        '${items.quantity ?? 0} Item',
                        style: GoogleFonts.leagueSpartan(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Order cancelled',
                        style: GoogleFonts.leagueSpartan(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        )
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Divider(
          color: Appcolors.secondarycolor,
          thickness: 2,
        )
      ],
    );
  }
}
