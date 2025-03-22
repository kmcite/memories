import 'package:memories/main.dart';
import 'package:memories/models/settings.dart';
import 'package:memories/models/user.dart';

final settignsRepository = SettingsRepository();

class SettingsRepository {
  final settingsRM = RM.inject(
    () => Settings(),
    persist: () => PersistState(
      key: 'settings',
      fromJson: Settings.fromJson,
      toJson: (s) => s.toJson(),
    ),
  );

  Settings settings([Settings? value]) {
    if (value != null)
      settingsRM
        ..state = value
        ..notify();
    return settingsRM.state;
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
}
