import 'package:flutter/material.dart';
import 'package:nuli_app/core/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final double height;
  final EdgeInsetsGeometry
  padding;
  final BorderRadius borderRadius;
  final BoxShadow? boxShadow;
  final IconData? icon;
  final double? iconSize;
  final FontWeight? fontWeight;
  final Color? buttonColor;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.height = 50,
    this.padding = const EdgeInsets.symmetric(horizontal: 110, vertical: 15),
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.boxShadow,
    this.icon,
    this.iconSize,
    this.fontWeight = FontWeight.bold,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = buttonColor ?? AppColors.secondaryGreen;
    return SizedBox(
      width: double.infinity,
      child: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: borderRadius,
                onTap: isLoading ? null : onPressed,
                child: Container(
                  height: height,
                  padding: padding,
                  decoration: BoxDecoration(
                    color: effectiveColor,
                    borderRadius: borderRadius,
                  ),
                  child: Center(
                    child: icon != null ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                icon,
                                color: Colors.white,
                                size: iconSize ?? 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                text,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: fontWeight ?? FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            text,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: fontWeight ?? FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                  ),
                ),
              ),
            ),
    );
  }
}
