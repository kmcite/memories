import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:forui/forui.dart';
import 'package:memories/api/settings_repository.dart';
import 'package:memories/objectbox.g.dart';
import 'package:memories/features/startup/locked_page.dart';
import 'main.dart';

export 'dart:developer' show log;
export 'dart:io';
export 'package:memories/features/memories/memory_page.dart';
export 'package:memories/_archive/memories_app.dart';
export 'package:states_rebuilder/states_rebuilder.dart';
export 'package:manager/manager.dart';

void main() {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  manager(
    App(),
    openStore: openStore,
  );
}

mixin _App {
  ThemeMode get themeMode => settignsRepository.themeMode();
  bool get dark => true;
}

class App extends UI with _App {
  void didMountWidget(context) {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigator.navigatorKey,
      home: LockedPage(),
      builder: (context, child) => FTheme(
        data: dark ? FThemes.yellow.dark : FThemes.yellow.light,
        child: child!,
      ),
      themeMode: themeMode,
    );
  }
}

final navigator = RM.navigate;

typedef UI = ReactiveStatelessWidget;
