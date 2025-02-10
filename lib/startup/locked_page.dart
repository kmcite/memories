import 'package:forui/forui.dart';
import 'package:memories/startup/forgot_password_page.dart';
import 'package:memories/memories/memories_page.dart';
import 'package:memories/main.dart';

import '../settings/settings_bloc.dart';

class LockedPage extends UI {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('memories'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'application is locked',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ).pad(),
            FTextField(
              onChange: unlockingBloc.setInputPassword,
              // placeholder: Text('password'),
            ).pad(),
            FButton(
              label: Text(
                'unlock',
              ),
              // backgroundColor: Colors.green,
              onPress: unlockingBloc.isUserAllowedToUnlock
                  ? () {
                      navigator.toReplacement(HomePage());
                    }
                  : null,
            ).pad(),
            FButton(
              label: 'forgot password?'.text(),
              onPress: () {
                navigator.toDialog(
                  ResetPasswordPage(),
                );
              },
            ).pad(),
          ],
        ),
      ),
    );
  }
}

final unlockingBloc = UnlockingBloc();

class UnlockingBloc {
  final inputPasswordRM = RM.inject(() => '');
  String get inputPassword => inputPasswordRM.state;
  void setInputPassword(String value) => inputPasswordRM.state = value;

  /// bloc to bloc contact -> settingsBloc -> settings repository
  bool get isUserAllowedToUnlock => settingsBloc.password == inputPassword;
}
