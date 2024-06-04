import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/src/package/custom_image/custom_mem_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// CustomNetworkImage is a custom widget that is used to display network images.
final class CustomNetworkImage extends StatelessWidget {
  /// The constructor for CustomNetworkImage.
  const CustomNetworkImage({
    super.key,
    this.imageUrl,
    this.emptyWidget,
    this.memCache = const CustomMemCache(
      memCacheHeight: 200,
      memCacheWidth: 200,
    ),
    this.boxFit = BoxFit.cover,
    this.size,
  });

  /// The URL of the image.
  final String? imageUrl;

  /// The widget to display when the image is empty.
  final Widget? emptyWidget;

  /// The custom mem cache class for the custom image package.
  /// Default is [200,200].
  final CustomMemCache memCache;

  /// The BoxFit for the image. Default is [BoxFit.cover].
  final BoxFit boxFit;

  /// The size of the image.
  final Size? size;
  @override
  Widget build(BuildContext context) {
    final url = imageUrl;
    if (url == null || url.isEmpty) return const SizedBox();
    return CachedNetworkImage(
      imageUrl: url,
      memCacheHeight: memCache.memCacheHeight,
      memCacheWidth: memCache.memCacheWidth,
      width: size?.width,
      height: size?.height,
      fit: boxFit,
      errorWidget: (context, url, error) {
        return emptyWidget ?? const SizedBox();
      },
      errorListener: (value) {
        if (kDebugMode) debugPrint('Error: $value');
      },
    );
  }
}
