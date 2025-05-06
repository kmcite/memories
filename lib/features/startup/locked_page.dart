import 'package:forui/forui.dart';
import 'package:memories/domain/api/settings_repository.dart';
import 'package:memories/features/startup/forgot_password_page.dart';
import 'package:memories/features/memories/memories_page.dart';
import 'package:memories/main.dart';

mixin UnlockingBloc {
  bool get isUserAllowedToUnlock =>
      settignsRepository.password() == inputPassword();
  final inputPassword = settignsRepository.inputPassword;
}

class LockedPage extends UI with UnlockingBloc {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(title: Text('memories')),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'application is locked',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ).pad(),
            FTextField(onChange: inputPassword, label: Text('Password')).pad(),
            FButton(
              label: Text('Unlock'),
              onPress: isUserAllowedToUnlock
                  ? () {
                      navigator.toReplacement(MemoriesPage());
                    }
                  : null,
            ).pad(),
            FButton(
              label: 'Forgot Password'.text(),
              onPress: () {
                navigator.toDialog(ResetPasswordPage());
              },
            ).pad(),
          ],
        ),
      ),
    );
  }
}
