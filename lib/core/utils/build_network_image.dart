import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget buildNetworkImage({
  required String? imageUrl,
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
  Widget? placeholder,
  Widget? errorWidget,
  double? errorIconSize = 50,
}) {
  if (imageUrl == null || imageUrl.trim().isEmpty) {
    return errorWidget ??
         Icon(
          Icons.broken_image,
          size: errorIconSize,
          color: Colors.grey,
        );
  }

  return CachedNetworkImage(
    imageUrl: imageUrl,
    width: width,
    height: height,
    fit: fit,
    placeholder: (context, url) => placeholder ??
        const Center(
          child: CircularProgressIndicator(),
        ),
    errorWidget: (context, url, error) => errorWidget ??
        Icon(
          Icons.error_outline,
          size: errorIconSize,
          color: Colors.redAccent,
        ),
  );
}
