import 'package:forui/forui.dart';
import 'package:memories/main.dart';

import 'settings_bloc.dart';

final popOverRM = false.inj();

class ThemeModeChange extends UI {
  const ThemeModeChange({super.key});

  @override
  Widget build(BuildContext context) {
    return FCard(
      title: Text('theme mode'),
      subtitle: FButton(
        onPress: popOverRM.toggle,
        label: FButton(
          label: Text(settingsBloc.themeMode.name.toLowerCase()),
          onPress: () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: ThemeMode.values.map(
              (themeMode) {
                return FButton(
                  onPress: () {
                    settingsBloc.setThemeMode(themeMode);
                    popOverRM.toggle();
                  },
                  label: themeMode.name.toLowerCase().text(),
                );
              },
            ).toList(),
          ),
          // visible: popOverRM.state,
        ),
      ),
      child: Text('change theme mode'),
    ).pad();
  }
}
