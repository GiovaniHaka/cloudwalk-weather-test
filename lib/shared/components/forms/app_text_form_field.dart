import 'package:cloudwalk/shared/commons/constants/padding_constants.dart';
import 'package:cloudwalk/shared/commons/constants/radius_constants.dart';
import 'package:cloudwalk/shared/commons/styles/app_text_style.dart';
import 'package:flutter/material.dart';

class AppTextFormField extends TextFormField {
  AppTextFormField({
    super.key,
    super.onChanged,
    String? hintText,
  }) : super(
          style: AppTextStyle.form(),
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(regularRadius)),
            ),
            contentPadding: const EdgeInsets.all(regularPadding),
            hintText: hintText,
            hintStyle: AppTextStyle.formHint(),
          ),
        );
}
