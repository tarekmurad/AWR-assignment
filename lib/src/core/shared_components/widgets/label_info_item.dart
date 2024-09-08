import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabelInfoWidget extends StatelessWidget {
  final String label;
  final String info;

  const LabelInfoWidget({
    super.key,
    required this.label,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 2.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xff9D9D9D),
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            info,
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xff1F2024),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
