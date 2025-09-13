import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yumquick/core/utils/App_colors.dart';

class OrderSummaryWidget extends StatelessWidget {
  final double subtotal;
  final double taxAndFees;
  final double delivery;
  final double totalPrice;

  const OrderSummaryWidget({
    super.key,
    required this.subtotal,
    required this.taxAndFees,
    required this.delivery,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
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
          Divider(color: Colors.grey.shade300, thickness: 1, height: 25.h),
          _buildSummaryRow("Total", "\$${totalPrice.toStringAsFixed(2)}",
              isTotal: true),
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
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.leagueSpartan(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: FontWeight.bold,
            color: isTotal ? Appcolors.secondarycolor : Colors.black,
          ),
        ),
      ],
    );
  }
}
