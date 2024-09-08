import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared_components/widgets/status_widget.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_dimens.dart';
import '../../../../core/utils/helpers.dart';
import '../../domain/entites/tracking.dart';

class TrackingItemWidget extends StatelessWidget {
  final Tracking tracking;
  final VoidCallback onPressed;

  const TrackingItemWidget({
    super.key,
    required this.tracking,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 8.h,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 14.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(Dimens.itemRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '#${tracking.ref}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    StatusWidget(
                      type: tracking.type,
                      color: AppColors.blackColor,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    StatusWidget(
                      type: tracking.status,
                      color: Helper.getStatusColor(tracking.status ?? ''),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            Row(
              children: [
                const Icon(
                  Icons.car_crash,
                  color: Colors.black,
                  size: 16.0,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                    '${tracking.car?.make} ${tracking.car?.model} - ${tracking.car?.licensePlate}'),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 16.0,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text('${tracking.customer?.name}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
