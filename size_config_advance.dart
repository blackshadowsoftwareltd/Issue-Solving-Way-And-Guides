part of '../extensions.dart';

extension BuildContextExt on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;
  double get shortestSide => mediaQuery.size.shortestSide;
  double get longestSide => mediaQuery.size.longestSide;

  Orientation get orientation => mediaQuery.orientation;
  bool get isPortrait => orientation == Orientation.portrait;
  bool get isLandscape => orientation == Orientation.landscape;

  bool get isPhone => shortestSide < 600;
  bool get isTablet => shortestSide >= 600 && shortestSide < 900;
  bool get isDesktop => shortestSide >= 900;
  bool get isSmallPhone => isPhone && shortestSide < 400;
  bool get isLargePhone => isPhone && shortestSide >= 400;
  bool get isSmallTablet => isTablet && shortestSide < 700;
  bool get isLargeTablet => isTablet && shortestSide >= 700;
  bool get isSmallDesktop => isDesktop && shortestSide < 1200;
  bool get isLargeDesktop => isDesktop && shortestSide >= 1200;
  bool get isSmall => isSmallPhone || isSmallTablet || isSmallDesktop;
  bool get isLarge => isLargePhone || isLargeTablet || isLargeDesktop;

  Future<T?> push<T>(Widget page) =>
      Navigator.of(this).push<T>(MaterialPageRoute(builder: (_) => page));

  Future<T?> pushNamed<T>(String page, [Object? args]) =>
      Navigator.of(this).pushNamed<T>(page, arguments: args);

  void pop<T>([T? result]) => Navigator.of(this).pop<T>(result);
}
