import 'package:forui/forui.dart';
import 'package:memories/utils/extensions/state.dart';
import 'package:memories/main.dart';
import 'package:memories/utils/navigator.dart';

import '../../domain/api/settings_repository.dart';
import 'user_profile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SettingsRepository settingsRepository = depend();
  ThemeMode get themeMode => settingsRepository.themeMode;
  void onThemeModeChanged(ThemeMode value) {
    settingsRepository.toggle(value);
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        suffixes: [
          FHeaderAction.x(onPress: navigator.back),
        ],
        title: Text('Settings'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            // label: FTile(
            //   title: _themeMode().name.toUpperCase().text(),
            // ),
            children: ThemeMode.values.map(
              (_themeMode) {
                return FTile(
                  enabled: _themeMode != themeMode,
                  title: Text(_themeMode.name.toUpperCase()),
                  onPress: () => onThemeModeChanged(_themeMode),
                );
              },
            ).toList(),
          ),
          UserProfile(),
          // PasswordSetup(),
        ],
      ),
    );
  }
}
