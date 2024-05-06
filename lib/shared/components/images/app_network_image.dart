import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudwalk/shared/commons/styles/app_colors.dart';
import 'package:flutter/material.dart';

/// [AppNetworkImage] is a network image with a placeholder and error widget that shows a loading indicator and an error icon, respectively.
/// It uses the [CachedNetworkImage] package to cache the image.
class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final BoxFit? fit;
  final Color? color;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.contain,
    this.height = 100,
    this.width = 100,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      fit: fit,
      imageUrl: imageUrl,
      color: color,
      placeholder: (context, url) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            height: height,
            width: width,
            constraints: const BoxConstraints(
              maxHeight: 60,
              maxWidth: 60,
            ),
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
