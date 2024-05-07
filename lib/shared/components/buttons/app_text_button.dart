import 'package:cloudwalk/shared/commons/constants/padding_constants.dart';
import 'package:cloudwalk/shared/commons/styles/app_colors.dart';
import 'package:cloudwalk/shared/commons/styles/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// [AppTextButton] is a text button.
class AppTextButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color? textColor;
  final EdgeInsets padding;

  const AppTextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.padding = const EdgeInsets.all(regularPadding),
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    final color = onTap == null ? AppColors.greyRegular : textColor;

    return CupertinoButton(
      padding: padding,
      disabledColor: AppColors.greyLight,
      onPressed: onTap,
      child: Text(
        text,
        style: AppTextStyle.buttonMedium().copyWith(
          color: color,
        ),
      ),
    );
  }

  const AppTextButton.primary({
    Key? key,
    required String text,
    required Function()? onTap,
    EdgeInsets padding = const EdgeInsets.all(regularPadding),
    IconData? prefixIcon,
    IconData? suffixIcon,
  }) : this(
          key: key,
          text: text,
          onTap: onTap,
          padding: padding,
          textColor: AppColors.primaryRegular,
        );
}
