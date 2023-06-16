import 'package:flutter/material.dart';
import 'package:grid_mobile/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final EdgeInsets? padding, margin;
  final Color? textColor, bgColor, colorIcon;
  final double? fontSize, width;
  final BorderRadius? borderRadius;
  final FontWeight? fontWeight;
  final bool isLoading, flat;
  final IconData? icon;
  final Widget? image;
  final void Function()? onPressed;

  const CustomButton(
      {super.key,
      this.text,
      this.textColor,
      this.bgColor,
      this.onPressed,
      this.width,
      this.padding,
      this.fontSize,
      this.fontWeight,
      this.borderRadius,
      this.isLoading = false,
      this.margin,
      this.flat = false,
      this.icon,
      this.colorIcon,
      this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:
            margin ?? const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        width: width,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: const Offset(0, 8),
              color: bgColor?.withOpacity(0.15) ?? Colors.transparent,
              blurRadius: 24,
              spreadRadius: 0)
        ]),
        child: flat
            ? TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: borderRadius ?? BorderRadius.circular(16)),
                  padding: padding,
                  backgroundColor: bgColor,
                ),
                onPressed: onPressed,
                child: Center(
                    child: isLoading
                        ? const SizedBox(
                            width: 17,
                            height: 17,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                                image ?? const SizedBox(),
                                icon != null
                                    ? Icon(
                                        icon,
                                        size: 30,
                                        color: colorIcon,
                                      )
                                    : const SizedBox(),
                                image != null || icon != null
                                    ? const SizedBox(width: 12)
                                    : const SizedBox(),
                                CustomText(
                                  text,
                                  color: textColor,
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                ),
                              ])),
              )
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            borderRadius ?? BorderRadius.circular(16)),
                    padding: padding,
                    elevation: 1,
                    backgroundColor: bgColor,
                    disabledBackgroundColor: bgColor),
                onPressed: onPressed,
                child: Center(
                    child: isLoading
                        ? const SizedBox(
                            width: 17,
                            height: 17,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                                image ?? const SizedBox(),
                                icon != null
                                    ? Icon(
                                        icon,
                                        size: 30,
                                        color: colorIcon,
                                      )
                                    : const SizedBox(),
                                image != null || icon != null
                                    ? const SizedBox(width: 12)
                                    : const SizedBox(),
                                CustomText(
                                  text,
                                  color: textColor,
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                ),
                              ])),
              ));
  }
}
