import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerInformationWidget extends StatelessWidget {
  final String name;
  final String phone;
  final String address;

  const CustomerInformationWidget({
    super.key,
    required this.name,
    required this.phone,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Customer Information',
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
          children: [
            const Icon(
              Icons.person,
              color: Colors.black,
              size: 20.0,
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.phone,
              color: Colors.black,
              size: 20.0,
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(
              phone,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.location_on,
              color: Colors.black,
              size: 20.0,
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(
              address,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ],
    );
  }
}
