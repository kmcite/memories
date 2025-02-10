import 'package:memories/main.dart';
import 'package:memories/settings/password_setup.dart';
import 'package:memories/settings/theme_mode_selection.dart';
import 'package:memories/settings/user_profile.dart';

class SettingsPage extends UI {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ThemeModeChange(),
          UserProfile(),
          PasswordSetup(),
        ],
      ),
    );
  }
}
