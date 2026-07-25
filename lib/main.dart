import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:memories/business/dark.dart';
import 'package:memories/business/navigation.dart';
import 'package:memories/features/memories/memories_page.dart';
import 'package:memories/main.dart';
import 'package:memories/domain/api/crud_repository.dart';
import 'package:memories/objectbox.g.dart' hide Store;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
export 'main.dart';
export 'dart:developer' show log;
export 'dart:io';
export 'package:manager/manager.dart';
export 'package:memories/features/memories/memory_page.dart';
export 'package:flutter/material.dart';
export 'package:memories/utils/notifier.dart';

void main() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  final appInfo = await PackageInfo.fromPlatform();
  final path = await getApplicationDocumentsDirectory();
  objects = await openStore(
    directory: join(path.path, appInfo.appName),
  );

  runApp(
    ProviderScope(
      observer: LoggingObserver(),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    final darkState = context(darkStateProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigator,
      home: MemoriesPage(),
      theme: ThemeData.light().copyWith(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      themeMode: darkState.dark() ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
