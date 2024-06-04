import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Make Adaptive for all platforms
class AdaptMobileView extends StatelessWidget {
  /// Define your custom widget for each platform
  const AdaptMobileView({
    required this.phone,
    required this.tablet,
    super.key,
  });

  /// Phone View
  final Widget phone;

  /// Tablet View
  final Widget tablet;

  @override
  Widget build(BuildContext context) {
    if (ResponsiveBreakpoints.of(context).isMobile) return phone;
    if (ResponsiveBreakpoints.of(context).isTablet) return tablet;

    return tablet;
  }
}
