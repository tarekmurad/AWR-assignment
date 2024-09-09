import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CallButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CallButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 44.w,
        height: 44.w,
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.call,
            color: Colors.white,
            size: 24.0,
          ),
        ),
      ),
    );
  }
}
