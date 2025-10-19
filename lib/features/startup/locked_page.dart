import 'package:forui/forui.dart';
import 'package:hux/hux.dart';
import 'package:memories/utils/extensions/state.dart';
import 'package:memories/domain/api/settings_repository.dart';
import 'package:memories/features/memories/memories_page.dart';
import 'package:memories/main.dart';
import 'package:memories/utils/navigator.dart';

class LockedPage extends StatefulWidget {
  @override
  State<LockedPage> createState() => _LockedPageState();
}

class _LockedPageState extends State<LockedPage> {
  late SettingsRepository settingsRepository = depend();

  late final password = TextEditingController(text: 'value');
  late final inputPassword = TextEditingController(text: 'value');
  bool get isUserAllowedToUnlock => password.text == inputPassword.text;

  void onUnlocked() {
    settingsRepository.unlock();
    navigator.toReplacement(MemoriesPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('memories')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8,
          children: [
            Icon(
              FeatherIcons.lock,
              size: 96,
            ),
            Text(
              'application is locked',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            FTextField(
              controller: inputPassword,
              label: Text('Password'),
            ),
            HuxButton(
              child: Text('Unlock'),
              onPressed: isUserAllowedToUnlock ? onUnlocked : null,
              icon: FeatherIcons.unlock,
            ),
            HuxButton(
              child: Text('Forgot Password'),
              onPressed: () {
                // navigator.toDialog(ResetPasswordPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
