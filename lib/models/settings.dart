import 'package:memories/models/user.dart';

import '../main.dart';

class Settings {
  Settings();
  int themeModeIndex = 0;
  ThemeMode get themeMode => ThemeMode.values.elementAt(themeModeIndex);
  set themeMode(ThemeMode val) => themeModeIndex = val.index;
  String password = '';
  int navigationIndex = 0;
  String inputPassword = '';
  User user = User();

  bool get stringify => true;

  List<Object> get props {
    return [
      themeModeIndex,
      password,
      navigationIndex,
      inputPassword,
      user,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'themeModeIndex': themeModeIndex,
      'password': password,
      'navigationIndex': navigationIndex,
      'inputPassword': inputPassword,
      'user': user.toMap(),
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings()
      ..themeModeIndex = (map['themeModeIndex'] ?? 0) as int
      ..password = (map['password'] ?? '') as String
      ..navigationIndex = (map['navigationIndex'] ?? 0) as int
      ..inputPassword = (map['inputPassword'] ?? '') as String
      ..user = User.fromMap(
        map['user'] as Map<String, dynamic>,
      );
  }

  String toJson() => json.encode(toMap());

  factory Settings.fromJson(String source) =>
      Settings.fromMap(json.decode(source) as Map<String, dynamic>);
}
