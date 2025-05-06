import 'package:forui/forui.dart';
import 'package:memories/domain/api/settings_repository.dart';
import 'package:memories/main.dart';
import 'package:memories/features/settings/password_setup.dart';
import 'package:memories/features/settings/user_profile.dart';

final themeModeRM = RM.injectStream(
  () => settignsRepository.stream.map((settings) => settings.themeMode),
  initialState: settignsRepository.value.themeMode,
);

ThemeMode _themeMode([ThemeMode? themeMode]) {
  if (themeMode != null) {
    settignsRepository.themeMode(themeMode);
  }
  return themeModeRM.state;
}

class SettingsPage extends UI {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        prefixActions: [
          FHeaderAction.x(onPress: navigator.back),
        ],
        title: Text('Settings'),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FTileGroup(
            label: FTile(
              title: _themeMode().name.toUpperCase().text(),
            ),
            children: ThemeMode.values.map(
              (themeMode) {
                return FTile(
                  enabled: themeMode != _themeMode(),
                  title: themeMode.name.toUpperCase().text(),
                  onPress: () => _themeMode(themeMode),
                );
              },
            ).toList(),
          ),
          UserProfile(),
          PasswordSetup(),
        ],
      ),
    );
  }
}
