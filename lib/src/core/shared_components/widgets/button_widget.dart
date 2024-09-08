import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/app_colors.dart';
import '../../styles/app_dimens.dart';
import 'loader_widget.dart';

class ButtonWidget extends StatefulWidget {
  final String labelText;
  final Color color;
  final VoidCallback onPressed;
  final bool? loading;
  final double? loadingSize;
  final double? labelTextFontSize;
  final double? buttonRadius;
  final Color? labelColor;
  final Color? borderColor;

  const ButtonWidget({
    Key? key,
    required this.labelText,
    required this.color,
    required this.onPressed,
    this.loading,
    this.loadingSize,
    this.labelTextFontSize,
    this.labelColor,
    this.buttonRadius,
    this.borderColor,
  }) : super(key: key);

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.buttonHeight,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (widget.loading == null || widget.loading == false) {
            widget.onPressed();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color,
          foregroundColor: AppColors.whiteColor.withOpacity(0.5),
          shadowColor: AppColors.grayColor.withOpacity(0),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: widget.borderColor ?? Colors.transparent,
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(
                widget.buttonRadius ?? Dimens.widgetRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.loading ?? false)
              SizedBox(
                width: widget.loadingSize ?? 20.w,
                height: widget.loadingSize ?? 20.w,
              )
            else
              const SizedBox.shrink(),
            Text(
              widget.labelText,
              style: TextStyle(
                fontSize: widget.labelTextFontSize ?? 14.sp,
                color: widget.labelColor ?? Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (widget.loading ?? false)
              LoaderWidget(
                size: widget.loadingSize ?? 20.w,
                color: Colors.white,
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
