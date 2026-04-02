import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:memories/business/adding_memory.dart';
import 'package:memories/business/business.dart';
import 'package:memories/business/dark.dart';
import 'package:memories/business/locking_mechanism.dart';
import 'package:memories/business/logging.dart';
import 'package:memories/business/medias.dart';
import 'package:memories/business/memories.dart';
import 'package:memories/business/memory_detail.dart';
import 'package:memories/business/navigation.dart';
import 'package:memories/business/reset_password.dart';
import 'package:memories/features/memories/memories_page.dart';
import 'package:memories/business/is_initialized.dart';
import 'package:memories/business/tags.dart';
import 'package:memories/main.dart';
import 'package:memories/domain/api/crud_repository.dart';
import 'package:memories/features/features.dart';
import 'package:memories/objectbox.g.dart' hide Store;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
export 'main.dart';
export 'dart:developer' show log;
export 'dart:io';
export 'package:memories/features/memories/memory_page.dart';
export 'package:flutter/material.dart';

final store = Store(
  business,
  initialState: Business(),
  middleware: [
    LoggingMW(), // must be first
    AddingMemoryMW(),
    LockingMechanismMW(),
    MemoriesMW(),
    // NavigationMW(),
    ResetPasswordMW(),
    MemoryDetailsMW(),
    TagsMW(),
    MediasMW(),
  ],
);

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
    StoreProvider<Business>(
      store: store,
      child: App(),
    ),
  );
}

class App extends UI {
  const App({super.key});

  @override
  void init() {
    dispatch(RemoveFlutterNativeSplash());
  }

  @override
  Widget build(BuildContext context) {
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
      themeMode: darkSignal() ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
