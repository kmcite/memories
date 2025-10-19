import 'package:memories/utils/architecture/repositories.dart';
import 'package:memories/main.dart';

class SettingsRepository extends Repository<bool> {
  ThemeMode themeMode = ThemeMode.system;
  bool dark = false;
  bool locked = false;

  void toggle(ThemeMode themeMode) {
    dark = !dark;
    this.themeMode = themeMode;
    notifyListeners();
  }

  void lock() {
    locked = true;
    notifyListeners();
  }

  void unlock() {
    locked = false;
    notifyListeners();
  }
}

// class SettingsRepository extends Repository<Settings> {
//   Settings settings([Settings? value]) {
//     if (value != null) call(value);
//     return this.value;
//   }

//   ThemeMode themeMode([ThemeMode? value]) {
//     if (value != null) {
//       settings(
//         settings()..themeMode = value,
//       );
//     }
//     return settings().themeMode;
//   }

//   String password([String? value]) {
//     if (value != null) {
//       settings(
//         settings()..password = value,
//       );
//     }
//     return settings().password;
//   }

//   int navigationIndex([int? value]) {
//     if (value != null) {
//       settings(
//         settings()..navigationIndex = value,
//       );
//     }
//     return settings().navigationIndex;
//   }

//   String inputPassword([String? value]) {
//     if (value != null) {
//       settings(
//         settings()..inputPassword = value,
//       );
//     }
//     return settings().inputPassword;
//   }

//   User user([User? value]) {
//     if (value != null) {
//       settings(
//         settings()..user = value,
//       );
//     }
//     return settings().user;
//   }

//   String name([String? value]) {
//     if (value != null) {
//       user(
//         user()..name = value,
//       );
//     }
//     return user().name;
//   }

//   String email([String? value]) {
//     if (value != null) {
//       user(
//         user()..email = value,
//       );
//     }
//     return user().email;
//   }

//   @override
//   Settings get initialState => Settings();
// }
