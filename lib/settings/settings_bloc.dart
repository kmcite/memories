import 'package:memories/main.dart';
import 'package:memories/settings/settings.dart';

final settingsBloc = SettingsBloc();

class SettingsBloc {
  final settingsRM = RM.inject(
    () => Settings(),
  );

  Settings get settings => settingsRM.state;
  void setSettings(Settings settings) {
    settingsRM.state = settings;
  }

  User get user => settings.user;
  String get name => user.name;
  String get email => user.email;

  void setName(String value) => setUser(user.copyWith(name: value));
  void setEmail(String value) => setUser(user.copyWith(email: value));

  String get password => settings.password;
  void setPassword(String value) {
    setSettings(
      settings.copyWith(password: value),
    );
  }

  ThemeMode get themeMode => settings.themeMode;
  void setThemeMode(ThemeMode? value) {
    setSettings(settings.copyWith(themeModeIndex: value?.index ?? 0));
  }

  void setUser(User value) {
    setSettings(
      settings.copyWith(user: value),
    );
  }
}
