import 'package:cloudwalk/shared/commons/constants/padding_constants.dart';
import 'package:flutter/material.dart';

/// [LoadingConcertsView] is a view that shows when the concerts are loading.
class LoadingConcertsView extends StatelessWidget {
  const LoadingConcertsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(viewPadding),
      child: CircularProgressIndicator(),
    );
  }
}
