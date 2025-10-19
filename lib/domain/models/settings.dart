// import 'package:memories/domain/models/user.dart';

// import '../../main.dart';

// class Settings extends Model {
//   Settings();
//   int themeModeIndex = 0;
//   ThemeMode get themeMode => ThemeMode.values.elementAt(themeModeIndex);
//   set themeMode(ThemeMode val) => themeModeIndex = val.index;
//   String password = '';
//   int navigationIndex = 0;
//   String inputPassword = '';
//   User user = User();

//   Map<String, dynamic> toJson() {
//     return <String, dynamic>{
//       'themeModeIndex': themeModeIndex,
//       'password': password,
//       'navigationIndex': navigationIndex,
//       'inputPassword': inputPassword,
//       'user': user.toMap(),
//     };
//   }

//   factory Settings.fromJson(Map<String, dynamic> map) {
//     return Settings()
//       ..themeModeIndex = (map['themeModeIndex'] ?? 0) as int
//       ..password = (map['password'] ?? '') as String
//       ..navigationIndex = (map['navigationIndex'] ?? 0) as int
//       ..inputPassword = (map['inputPassword'] ?? '') as String
//       ..user = User.fromMap(map['user'] as Map<String, dynamic>);
//   }

//   @override
//   int id = 0;
// }
