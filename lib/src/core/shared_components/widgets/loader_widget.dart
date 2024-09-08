import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';

class LoaderWidget extends StatelessWidget {
  final double size;
  final Color? color;

  const LoaderWidget({
    super.key,
    required this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 3.0,
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
