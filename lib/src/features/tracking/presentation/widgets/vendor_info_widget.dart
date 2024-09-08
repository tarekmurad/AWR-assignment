import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared_components/widgets/call_button.dart';
import '../../../../core/styles/app_colors.dart';

class VendorInfoWidget extends StatelessWidget {
  final String vendorName;
  final VoidCallback onCallPressed;

  const VendorInfoWidget({
    super.key,
    required this.vendorName,
    required this.onCallPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              vendorName,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Vendor Man",
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xff9D9D9D),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        CallButton(
          onPressed: onCallPressed,
        ),
      ],
    );
  }
}
