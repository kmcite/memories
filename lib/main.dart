import 'package:forui/forui.dart';
import 'package:memories/startup/locked_page.dart';
import 'main.dart';

export 'dart:developer' show log;
export 'dart:io';
export 'package:memories/memories/memory_page.dart';
export 'package:memories/_archive/memories_app.dart';
// export 'package:states_rebuilder/states_rebuilder.dart'hide Animate;
export 'package:manager/manager.dart' hide Animate, TextDirection;

import 'settings/settings_bloc.dart';

void main() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  await RM.storageInitializer(HiveStorage());
  // store = await openStore(
  //   directory: path.join(
  //     (await getApplicationDocumentsDirectory()).path + 'memories',
  //   ),
  // );

  runApp(App());
}

class App extends UI {
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
        data: FThemes.yellow.dark,
        child: child!,
      ),
      // theme: ShadThemeData(
      //   colorScheme: ShadRedColorScheme.light(),
      //   brightness: Brightness.light,
      // ),
      // darkTheme: ShadThemeData(
      //   colorScheme: ShadRedColorScheme.dark(),
      //   brightness: Brightness.dark,
      // ),
      themeMode: settingsBloc.themeMode,
    );
  }
}

/// bloc,repo
final navigator = RM.navigate;
late Store store;
