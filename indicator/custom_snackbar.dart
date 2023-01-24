import 'package:flutter/material.dart';
import 'package:food_app/helpers/constants/colors/colors.dart'
    show red400, white;

import '../../helpers/routes/custom_routes.dart' show glovalNavigatorKey;
import 'loading_indicator.dart' show FadingCircle;

///? loading
Future<void> showLoading(BuildContext? context) async => showCustomSnack(
    context: context,
    duration: const Duration(seconds: 3),
    onPressed: () {},
    title: 'Loading',
    subTitle: null,
    isCenter: true,
    isLoading: true);

///? showError
Future<void> showErrorSnack(
        {required BuildContext? context, required String? subTitle}) =>
    showCustomSnack(
        context: context,
        duration: const Duration(seconds: 5),
        onPressed: () {},
        title: 'Error!',
        subTitle: subTitle,
        isCenter: false,
        backColor: red400,
        isLoading: false);

///? showWuccess
Future<void> showSuccessSnack(
        {required BuildContext? context, required String? subTitle}) =>
    showCustomSnack(
        context: context,
        duration: const Duration(seconds: 3),
        onPressed: () {},
        title: 'Success',
        subTitle: subTitle,
        isCenter: false,
        isLoading: false);

///? stopSnackbar
Future<void> stopSnack({required BuildContext? context}) async {
  if (glovalNavigatorKey.currentContext == null && context == null) return;
  ScaffoldMessenger.of(glovalNavigatorKey.currentContext ?? context!)
      .hideCurrentSnackBar();
}

///?  custom
Future<void> showCustomSnack(
    {required BuildContext? context,
    required VoidCallback onPressed,
    required String title,
    required String? subTitle,
    required Duration? duration,
    required bool isCenter,
    required bool? isLoading,
    Color? backColor}) async {
  if (glovalNavigatorKey.currentContext == null && context == null) return;
  ScaffoldMessenger.of(glovalNavigatorKey.currentContext ?? context!)
      .hideCurrentSnackBar();
  ScaffoldMessenger.of(glovalNavigatorKey.currentContext ?? context!)
      .showSnackBar(SnackBar(
    duration: duration ?? const Duration(seconds: 10),
    dismissDirection: isLoading == null || !isLoading
        ? DismissDirection.horizontal
        : DismissDirection.none,
    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: isCenter
        ? Center(
            child: CustomSnackBody(
            onPressed: onPressed,
            title: title,
            subTitle: subTitle,
            isLoading: isLoading,
          ))
        : CustomSnackBody(
            onPressed: onPressed,
            title: title,
            subTitle: subTitle,
            isLoading: isLoading,
            backColor: backColor,
          ),
  ));
}

class CustomSnackBody extends StatelessWidget {
  const CustomSnackBody({
    Key? key,
    required this.onPressed,
    required this.title,
    this.subTitle,
    this.backColor,
    this.isLoading,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String title;
  final String? subTitle;
  final bool? isLoading;
  final Color? backColor;
  @override
  Widget build(BuildContext context) {
    final notLoading = isLoading == null || !isLoading!;

    return InkWell(
      onTap: notLoading ? onPressed : null,
      child: SizedBox(
        height: notLoading ? 60 : 80,
        width: notLoading ? MediaQuery.of(context).size.width : 80,
        child: Stack(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: notLoading ? 60 : 80,
            margin: notLoading ? const EdgeInsets.only(right: 10) : null,
            padding: notLoading
                ? const EdgeInsets.symmetric(vertical: 2, horizontal: 15)
                : const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: backColor ?? Colors.white,
              borderRadius: BorderRadius.circular(notLoading ? 8 : 20),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    spreadRadius: 0,
                    offset: Offset(5, 8)),
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 0,
                    offset: Offset(-3, -5))
              ],
            ),
            child: notLoading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _text(
                        title,
                        TextStyle(
                            fontSize: 15,
                            color: backColor != null ? white : Colors.black87),
                      ),
                      if (subTitle != null)
                        _text(
                          subTitle!,
                          TextStyle(
                            fontSize: 14,
                            color: backColor != null ? white : Colors.black87,
                          ),
                        )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const FittedBox(
                        child: SizedBox(
                            width: 45,
                            height: 45,
                            child: FadingCircle(color: Colors.black45)),
                      ),
                      _text(
                        title,
                        const TextStyle(fontSize: 13, color: Colors.black87),
                      )
                    ],
                  ),
          ),
          if (notLoading)
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                child: Transform.rotate(
                  angle: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: backColor ?? Colors.white,
                          borderRadius: BorderRadius.circular(6)),
                      child: Transform.rotate(
                        angle: 150,
                        child: Icon(Icons.close,
                            size: 22,
                            color: backColor != null ? white : Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ]),
      ),
    );
  }
}

Widget _text(String message, TextStyle style) => Flexible(
    child: Text(message,
        maxLines: 1, overflow: TextOverflow.ellipsis, style: style));
