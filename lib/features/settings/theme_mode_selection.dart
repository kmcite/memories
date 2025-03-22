import 'package:forui/forui.dart';
import 'package:memories/api/settings_repository.dart';
import 'package:memories/main.dart';

final popOverRM = false.inj();

mixin ThemeModeBloc {
  Modifier<ThemeMode> get themeMode => settignsRepository.themeMode;
}

class ThemeModeChange extends UI with ThemeModeBloc {
  const ThemeModeChange({super.key});

  @override
  Widget build(BuildContext context) {
    return FCard(
      title: Text('theme mode'),
      subtitle: FButton(
        onPress: popOverRM.toggle,
        label: FButton(
          label: Text(themeMode().name.toLowerCase()),
          onPress: () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: ThemeMode.values.map(
              (themeMode_) {
                return FButton(
                  onPress: () {
                    themeMode(themeMode_);
                    popOverRM.toggle();
                  },
                  label: themeMode_.name.toLowerCase().text(),
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
