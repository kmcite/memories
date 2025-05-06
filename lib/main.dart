import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:forui/forui.dart';
import 'package:memories/domain/api/settings_repository.dart';
import 'package:memories/features/memories/memories_page.dart';
import 'package:memories/objectbox.g.dart';
import 'main.dart';

export 'dart:developer' show log;
export 'dart:io';
export 'package:memories/features/memories/memory_page.dart';
export 'package:states_rebuilder/states_rebuilder.dart';
export 'package:manager/manager.dart';
export 'package:flutter/material.dart';

void main() {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  manager(App(), openStore: openStore);
}

final themeModeRM = RM.injectStream(
  () => settignsRepository.stream.map((settings) => settings.themeMode),
  initialState: ThemeMode.system,
);

class App extends UI {
  const App({super.key});
  void didMountWidget(context) {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigator.navigatorKey,
      home: MemoriesPage(),
      //  LockedPage()
      builder: (context, child) {
        return FTheme(
          data: themeModeRM.state == ThemeMode.dark
              ? FThemes.yellow.dark
              : FThemes.yellow.light,
          child: child!,
        );
      },
      themeMode: themeModeRM.state,
    );
  }
}

final navigator = RM.navigate;
