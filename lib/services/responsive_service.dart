import 'package:flutter/material.dart';

class ResponsiveService {
  // Singleton approach
  static final ResponsiveService _instance = ResponsiveService._internal();
  factory ResponsiveService() => _instance;
  ResponsiveService._internal();

  // Breakpoints for different screen sizes
  static const int smallScreenWidth = 320;
  static const int largeScreenWidth = 600;
  static const int tabletScreenWidth = 1024;

  // Determine the type of device
  bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < smallScreenWidth;
  }

  bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= smallScreenWidth && MediaQuery.of(context).size.width < largeScreenWidth;
  }

  bool isTabletScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= largeScreenWidth && MediaQuery.of(context).size.width < tabletScreenWidth;
  }

  bool isDesktopScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= tabletScreenWidth;
  }

  // Get dynamic sizing for padding, margins, etc.
  double getResponsiveValue({
    required BuildContext context,
    required double small,
    required double large,
    required double tablet,
    required double desktop,
  }) {
    if (isDesktopScreen(context)) {
      return desktop;
    } else if (isTabletScreen(context)) {
      return tablet;
    } else if (isLargeScreen(context)) {
      return large;
    } else {
      return small;
    }
  }
}
