import 'package:memories/main.dart';

extension WidgetExtensions on Widget {
  Widget pad({
    double all = 8,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        left ?? all,
        top ?? all,
        right ?? all,
        bottom ?? all,
      ),
      child: this,
    );
  }
}
