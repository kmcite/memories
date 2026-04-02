import 'package:memories/main.dart';

final navigator = GlobalKey<NavigatorState>();
navigateTo(Widget page) {
  navigator.currentState?.push(
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

navigateToAndRemoveUntil(Widget page) {
  navigator.currentState?.pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => page),
    (route) => false,
  );
}

navigateToDialog(Widget dialog) {
  showDialog(
    context: navigator.currentContext!,
    builder: (context) => dialog,
  );
}

navigateBack() {
  navigator.currentState?.pop();
}
