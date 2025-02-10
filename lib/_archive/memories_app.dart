// import 'package:memories/main.dart';

// import '../settings/settings.dart';

// @deprecated
// class MemoriesApp extends UI {
//   final borderRadius = BorderRadius.circular(16);
//   shape() => RoundedRectangleBorder(borderRadius: borderRadius);

//   DialogTheme _buildDialogTheme(Color backgroundColor) {
//     return DialogTheme(
//       shape: shape(),
//       backgroundColor: backgroundColor,
//       elevation: 6,
//     );
//   }

//   ElevatedButtonThemeData _buildButtonTheme(Color backgroundColor) {
//     return ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         foregroundColor: Colors.white,
//         backgroundColor: backgroundColor,
//         shape: shape(),
//         elevation: 5,
//         shadowColor: Colors.black.withOpacity(0.3),
//       ),
//     );
//   }

//   didMountWidget(_) => FlutterNativeSplash.remove();

//   build(_) => MaterialApp(
//         debugShowCheckedModeBanner: false,
//         // home: App(),
//         theme: ThemeData(
//           dialogTheme: _buildDialogTheme(Colors.white),
//           inputDecorationTheme: InputDecorationTheme(
//             border: OutlineInputBorder(borderRadius: borderRadius),
//             filled: true,
//             fillColor: Colors.blue.withOpacity(.15),
//             labelStyle: TextStyle(color: Colors.blue),
//             hintStyle: TextStyle(color: Colors.blueGrey),
//           ),
//           elevatedButtonTheme: _buildButtonTheme(Colors.blueAccent),
//           floatingActionButtonTheme: FloatingActionButtonThemeData(
//             shape: shape(),
//             backgroundColor: Colors.blueAccent,
//             foregroundColor: Colors.white,
//             elevation: 8,
//           ),
//           primaryColor: Colors.blue,
//           colorScheme:
//               ColorScheme.light(primary: Colors.blue, secondary: Colors.orange)
//                   .copyWith(secondary: Colors.orangeAccent),
//         ),
//         darkTheme: ThemeData(
//           dialogTheme: _buildDialogTheme(Colors.grey[850]!),
//           brightness: Brightness.dark,
//           inputDecorationTheme: InputDecorationTheme(
//             border: OutlineInputBorder(borderRadius: borderRadius),
//             filled: true,
//             fillColor: Colors.yellow[700]?.withOpacity(.15),
//             labelStyle: TextStyle(color: Colors.yellowAccent),
//             hintStyle: TextStyle(color: Colors.grey),
//           ),
//           elevatedButtonTheme: _buildButtonTheme(Colors.orangeAccent),
//           floatingActionButtonTheme: FloatingActionButtonThemeData(
//             shape: shape(),
//             backgroundColor: Colors.orangeAccent,
//             foregroundColor: Colors.white,
//             elevation: 8,
//           ),
//           primaryColor: Colors.blueGrey,
//           colorScheme:
//               ColorScheme.dark(primary: Colors.blueGrey, secondary: Colors.red)
//                   .copyWith(secondary: Colors.redAccent),
//         ),
//         themeMode: settingsBloc.themeMode,
//       );
// }
