import 'package:cloudwalk/shared/commons/styles/app_colors.dart';
import 'package:cloudwalk/shared/services/connectivity/widgets/connectivity_status_icon.dart';
import 'package:flutter/material.dart';

/// [AppTopBar] is a custom [AppBar] that implement app design system.
class AppTopBar extends AppBar {
  AppTopBar({
    super.key,
    String? titleText,
    Widget? title,
    super.leading,
    List<Widget>? actions,
    Color? backgroundColor,
    super.automaticallyImplyLeading,
    super.toolbarHeight,
    super.centerTitle = true,
  }) : super(
          title: title,
          elevation: 0,
          actions: [
            ...actions ?? [],
            const SizedBox(width: 10),
            const ConnectivityStatusIcon(),
            const SizedBox(width: 10),
          ],
          backgroundColor: backgroundColor ?? AppColors.backgroundColor,
          surfaceTintColor: Colors.transparent,
        );
}
