// features/MyOrders/view/widgets/order_card_active.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:yumquick/core/helper/my_navgetor.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/widgets/Custom_bottom.dart';
import 'package:yumquick/features/MyOrders/data/models/OrderResponse.dart';
import 'package:yumquick/features/MyOrders/manager/cubit_canceld/canceld_state.dart';
import 'package:yumquick/features/MyOrders/manager/cubit_canceld/cubit_canceld.dart';
import 'package:yumquick/features/OrderDetails/Views/OrderDetails.dart';


class OrderCardActive extends StatelessWidget {
  final Active order;
  final Items items;

  const OrderCardActive({super.key, required this.order, required this.items,});

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
            GestureDetector(
              onTap: (){
                MyNavigator.goTo(context, Orderdetails(
                  detiles: order.items!,
                  order: order,
                ),type: NavigatorType.push);
              },
              child: Container(
                  height: 108.h,
                  width: 71.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(items.imagePath ?? ''))
                  )
              ),
            ),
            SizedBox(width: 15.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(items.name!, style: GoogleFonts.leagueSpartan(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),),
                SizedBox(height: 10.h),
                Text(formatOrderDate(order.orderDate!),
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),),
                SizedBox(height: 10.h),
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
                )
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Text('\$${order.subtotal}', style: GoogleFonts.leagueSpartan(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Appcolors.secondarycolor,
                  )),
                  SizedBox(height: 10.h),
                  Text('${items.quantity!.toString()} Item',
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(height: 10.h),
                  CustomBottom(width: 107.w,
                    height: 26.h,
                    backgroundColor: Color(0xffFFDECF),
                    reduis: 100.r,
                    text: 'Track Driver',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    letterspacing: 0,
                    lineheight: 0,
                    colortext: Appcolors.secondarycolor,
                  )
                ],
              ),
            )

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
