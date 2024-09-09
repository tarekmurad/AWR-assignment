import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../styles/app_colors.dart';
import '../../styles/assets.dart';

class LocationDetailsWidget extends StatelessWidget {
  final String sourceAddress;
  final String destinationAddress;

  const LocationDetailsWidget({
    Key? key,
    required this.sourceAddress,
    required this.destinationAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location Details',
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  Assets.navIcon,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 5),
                _buildDot(),
                const SizedBox(height: 5),
                _buildDot(),
                const SizedBox(height: 5),
                _buildDot(),
                const SizedBox(height: 5),
                _buildDot(),
                const SizedBox(height: 5),
                SvgPicture.asset(
                  Assets.pinIcon,
                  fit: BoxFit.fill,
                ),
              ],
            ),
            SizedBox(width: 20.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Source',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xff9D9D9D),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      sourceAddress,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Destination',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xff9D9D9D),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      destinationAddress,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDot() {
    return Container(
      width: 2.w,
      height: 2.w,
      color: Colors.black,
    );
  }
}
