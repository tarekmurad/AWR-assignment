import 'package:aw_rostamani/src/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/shared_components/widgets/status_widget.dart';
import '../../../../core/styles/app_dimens.dart';
import '../../../../core/utils/helpers.dart';
import '../../domain/entites/assignment.dart';

class AssignmentItemWidget extends StatelessWidget {
  final Assignment assignment;
  final VoidCallback onPressed;

  const AssignmentItemWidget({
    super.key,
    required this.assignment,
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
                  '#${assignment.ref}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    StatusWidget(
                      type: assignment.type,
                      color: AppColors.blackColor,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    StatusWidget(
                      type: assignment.status,
                      color: Helper.getStatusColor(assignment.status ?? ''),
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
                    '${assignment.car?.make} ${assignment.car?.model} - ${assignment.car?.licensePlate}'),
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
                Text('${assignment.customer?.name}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.black,
                      size: 16.0,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    if (assignment.type == AssignmentType.pick_up.name)
                      Text('${assignment.sourceLocation?.addressNotes}')
                    else if (assignment.type == AssignmentType.drop_off.name)
                      Text('${assignment.destinationLocation?.addressNotes}'),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 14.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
