import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudwalk/shared/commons/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final BoxFit? fit;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.contain,
    this.height = 100,
    this.width = 100,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      fit: fit,
      imageUrl: imageUrl,
      placeholder: (context, url) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            height: height,
            width: width,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return const Center(
          child: Icon(
            Icons.error,
            color: AppColors.redRegular,
          ),
        );
      },
    );
  }
}
