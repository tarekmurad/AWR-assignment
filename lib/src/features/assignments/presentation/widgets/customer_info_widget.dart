import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared_components/widgets/call_button.dart';
import '../../../../core/styles/app_colors.dart';

class CustomerInfoWidget extends StatelessWidget {
  final String customerName;
  final VoidCallback onCallPressed;

  const CustomerInfoWidget({
    super.key,
    required this.customerName,
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
              customerName,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Customer Name",
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
