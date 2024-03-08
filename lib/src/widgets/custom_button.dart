import 'package:flutter/material.dart';
import 'package:partner/Utils/Colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.height,
    this.width,
    this.bgColor,
    this.onTap,
    this.textStyle,
    required this.title,
    this.radius,
  });

  final double? height;
  final double? width;
  final Color? bgColor;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final String title;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.maxFinite,
      height: height ?? 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 10,
          backgroundColor: bgColor ?? AppThemeColor.darkBlueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 6),
          ),
        ),
        onPressed: onTap,
        child: Text(
          title,
          style: textStyle ??
              const TextStyle(
                color: AppThemeColor.pureWhiteColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
        ),
      ),
    );
  }
}
