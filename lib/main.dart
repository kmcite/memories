import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:forui/forui.dart';
import 'package:memories/utils/extensions/state.dart';
import 'package:memories/features/startup/locked_page.dart';
import 'package:memories/domain/api/memories_repository.dart';
import 'package:memories/utils/architecture/repositories.dart';
import 'package:memories/utils/architecture/services.dart';
import 'package:memories/utils/navigator.dart';
import 'package:memories/objectbox.g.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'domain/api/settings_repository.dart';
import 'features/memories/memories_page.dart';
import 'main.dart';
export 'dart:developer' show log;
export 'dart:io';
export 'package:memories/features/memories/memory_page.dart';
export 'package:flutter/material.dart';

void main() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  final appInfo = await PackageInfo.fromPlatform();
  final path = await getApplicationDocumentsDirectory();

  final store = await openStore(directory: join(path.path, appInfo.appName));

  service(store);

  repository(MemoriesRepository());
  repository(SettingsRepository());

  runApp(App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late SettingsRepository settingsRepository = depend();

  bool get dark => settingsRepository.dark;
  bool get locked => settingsRepository.locked;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigator.navigatorKey,
      home: locked ? LockedPage() : MemoriesPage(),
      builder: (context, child) {
        return FTheme(
          data: dark ? FThemes.yellow.dark : FThemes.yellow.light,
          child: child!,
        );
      },
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: dark ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
