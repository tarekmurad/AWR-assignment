import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'label_info_item.dart';

class VehicleInformationWidget extends StatelessWidget {
  final String plateNumber;
  final String vehicleMake;
  final String vehicleModel;
  final String vehicleColor;

  const VehicleInformationWidget({
    super.key,
    required this.plateNumber,
    required this.vehicleMake,
    required this.vehicleModel,
    required this.vehicleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vehicle Information',
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelInfoWidget(
                  label: 'Plate Number',
                  info: plateNumber,
                ),
                LabelInfoWidget(
                  label: 'Vehicle Make',
                  info: vehicleMake,
                ),
                LabelInfoWidget(
                  label: 'Vehicle Model',
                  info: vehicleModel,
                ),
                LabelInfoWidget(
                  label: 'Vehicle Color',
                  info: vehicleColor,
                ),
              ],
            ),
            Container(
              height: 85.h,
              width: 85.w,
              margin: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage("assets/images/$vehicleMake.png"),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
