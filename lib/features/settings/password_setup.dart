import 'package:forui/forui.dart';
import 'package:memories/features/startup/locked_page.dart';
import 'package:memories/main.dart';
import 'package:memories/features/settings/change_password_dialog.dart';

void _lock() {
  navigator.toAndRemoveUntil(LockedPage());
}

void _changePassword() {
  navigator.toDialog(ChangePasswordDialog());
}

class PasswordSetup extends UI {
  const PasswordSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return FCard(
      title: Text('password'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FButton(
            onPress: _changePassword,
            label: 'change password'.text(),
          ),
          FButton(
            onPress: _lock,
            label: 'lock'.text(),
          ),
        ],
      ),
    ).pad();
  }
}
