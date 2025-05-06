import 'package:memories/main.dart';
import 'package:memories/domain/models/settings.dart';
import 'package:memories/domain/models/user.dart';

final settignsRepository = SettingsRepository();

class SettingsRepository extends Repository<Settings> {
  Settings settings([Settings? value]) {
    if (value != null) call(value);
    return this.value;
  }

  ThemeMode themeMode([ThemeMode? value]) {
    if (value != null) {
      settings(
        settings()..themeMode = value,
      );
    }
    return settings().themeMode;
  }

  String password([String? value]) {
    if (value != null) {
      settings(
        settings()..password = value,
      );
    }
    return settings().password;
  }

  int navigationIndex([int? value]) {
    if (value != null) {
      settings(
        settings()..navigationIndex = value,
      );
    }
    return settings().navigationIndex;
  }

  String inputPassword([String? value]) {
    if (value != null) {
      settings(
        settings()..inputPassword = value,
      );
    }
    return settings().inputPassword;
  }

  User user([User? value]) {
    if (value != null) {
      settings(
        settings()..user = value,
      );
    }
    return settings().user;
  }

  String name([String? value]) {
    if (value != null) {
      user(
        user()..name = value,
      );
    }
    return user().name;
  }

  String email([String? value]) {
    if (value != null) {
      user(
        user()..email = value,
      );
    }
    return user().email;
  }

  @override
  Settings get initialState => Settings();
}
