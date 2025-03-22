import 'package:forui/forui.dart';
import 'package:memories/features/startup/locked_page.dart';
import 'package:memories/main.dart';
import 'package:memories/features/settings/change_password_dialog.dart';

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
            onPress: () => navigator.toDialog(ChangePasswordDialog()),
            label: 'change password'.text(),
          ),
          FButton(
            onPress: () => navigator.toAndRemoveUntil(LockedPage()),
            label: 'lock'.text(),
          ),
        ],
      ),
    ).pad();
  }
}
