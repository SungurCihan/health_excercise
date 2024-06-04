import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Make Adaptive for all platforms
class AdaptAlView extends StatelessWidget {
  /// Define your custom widget for each platform
  const AdaptAlView({
    required this.phone,
    required this.tablet,
    required this.desktop,
    super.key,
  });

  /// Phone View
  final Widget phone;

  /// Tablet View
  final Widget tablet;

  /// Desktop View
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    if (ResponsiveBreakpoints.of(context).isMobile) return phone;
    if (ResponsiveBreakpoints.of(context).isTablet) return tablet;
    if (ResponsiveBreakpoints.of(context).isDesktop) return desktop;

    return phone;
  }
}
