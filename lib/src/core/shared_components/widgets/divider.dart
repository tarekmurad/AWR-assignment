import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DividerWidget extends StatelessWidget {
  final Color? color;

  const DividerWidget({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        Divider(
          color: color ?? const Color(0xffEBEBEB),
        ),
        SizedBox(
          height: 20.h,
        )
      ],
    );
  }
}
