import 'package:flutter/widgets.dart';
class APPOptions {
   double textScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor;
  }

  TextDirection resolvedTextDirection() {
    return TextDirection.ltr;
  }

}
class ApplyTextOptions extends StatelessWidget{
  final Widget child;
  const ApplyTextOptions({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final options = APPOptions();
    final textDirection = options.resolvedTextDirection();
    final textScaleFactor = options.textScaleFactor(context);

    Widget widget = MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: textScaleFactor,
      ),
      child: child,
    );
    return textDirection == null
        ? widget
        : Directionality(
      textDirection: textDirection,
      child: widget,
    );
  }
}