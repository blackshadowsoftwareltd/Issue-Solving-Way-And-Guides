class ScreenSize {
  static late MediaQueryData _mediaQueryData;
  static late double width;
  static late double height;
  static late double defaultSize;
  static late double fontSize;
  static late Orientation orientation;
  static late bool isPhone;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    width = _mediaQueryData.size.width;
    height = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    ///? MediaQuery.of(context).textScaleFactor >> device font size
    fontSize = MediaQuery.of(context).textScaleFactor;
    isPhone = width < 650;
  }
}
