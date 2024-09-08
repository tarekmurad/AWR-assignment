import 'package:aw_rostamani/src/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/app_dimens.dart';

class StatusWidget extends StatelessWidget {
  final String? type;
  final Color? color;

  const StatusWidget({Key? key, this.type, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(Dimens.medRadius),
      ),
      child: Text(
        type?.replaceAll('_', ' ').capitalize() ?? '',
        style: TextStyle(
          fontSize: 10.sp,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
