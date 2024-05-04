import 'package:cloudwalk/shared/commons/constants/radius_constants.dart';
import 'package:cloudwalk/shared/commons/styles/app_colors.dart';
import 'package:cloudwalk/shared/commons/styles/app_text_style.dart';
import 'package:flutter/material.dart';

class AppSmallFilledButton extends StatelessWidget {
  final Function()? onTap;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData? icon;
  final String? text;

  const AppSmallFilledButton({
    super.key,
    required this.onTap,
    required this.backgroundColor,
    required this.foregroundColor,
    this.text,
    this.icon,
  });

  static double height = 30;

  @override
  Widget build(BuildContext context) {
    final haveSeparator = icon != null && text != null;

    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return AppColors.greyLight;
              }
              return backgroundColor;
            },
          ),
          elevation: MaterialStateProperty.resolveWith<double?>(
            (Set<MaterialState> states) {
              return 0;
            },
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(regularRadius),
            ),
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return foregroundColor;
            },
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return foregroundColor.withOpacity(0.2);
            },
          ),
          textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
            (Set<MaterialState> states) {
              return AppTextStyle.buttonSmall().copyWith(
                color: foregroundColor,
              );
            },
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (haveSeparator) const SizedBox(width: 8),
            if (text != null)
              Text(
                text!,
                textAlign: TextAlign.center,
              ),
            if (haveSeparator) const SizedBox(width: 8),
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: foregroundColor,
              ),
            ],
          ],
        ),
      ),
    );
  }

  const AppSmallFilledButton.primary({
    super.key,
    this.text,
    required this.onTap,
    this.backgroundColor = AppColors.primaryRegular,
    this.foregroundColor = Colors.white,
    this.icon,
  });

  const AppSmallFilledButton.secondary({
    super.key,
    this.text,
    required this.onTap,
    this.backgroundColor = AppColors.greyLightest,
    this.foregroundColor = AppColors.primaryRegular,
    this.icon,
  });
}
