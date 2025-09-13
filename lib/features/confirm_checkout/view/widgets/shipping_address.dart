import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yumquick/core/utils/App_colors.dart';

class ShippingAddressWidget extends StatelessWidget {
  final String shippingAddress;
  final ValueChanged<String> onAddressChanged;

  const ShippingAddressWidget({
    super.key,
    required this.shippingAddress,
    required this.onAddressChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.w),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Shipping Address",
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  shippingAddress,
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _showAddressDialog(context),
            child: Text(
              "Open Maps",
              style: GoogleFonts.leagueSpartan(
                fontSize: 14.sp,
                color: Appcolors.secondarycolor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddressDialog(BuildContext context) {
    String tempAddress = shippingAddress;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Edit Shipping Address",
            style: GoogleFonts.leagueSpartan(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: TextField(
            maxLines: 3,
            controller: TextEditingController(text: tempAddress),
            onChanged: (value) {
              tempAddress = value;
            },
            decoration: InputDecoration(
              hintText: "Enter your address",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel",
                  style: GoogleFonts.leagueSpartan(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                onAddressChanged(tempAddress);
                Navigator.of(context).pop();
              },
              child: Text(
                "Save",
                style: GoogleFonts.leagueSpartan(
                  color: Appcolors.secondarycolor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
