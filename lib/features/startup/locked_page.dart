import 'package:memories/business/locking_mechanism.dart';
import 'package:memories/business/navigation.dart';
import 'package:memories/features/startup/reset_password_page.dart';
import 'package:memories/main.dart';
import 'package:memories/features/features.dart';

class LockedPage extends UI {
  const LockedPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: state.lockingMechanism.locked
          ? Colors.red
          : Colors.green,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .stretch,
          spacing: 8,
          children: [
            Icon(
              state.lockingMechanism.locked
                  ? Icons.lock
                  : Icons.face_unlock_sharp,
              size: 96,
            ),
            Text(
              'application is locked',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              initialValue: state.lockingMechanism.typedPassword,
              onChanged: (value) => dispatch(ChangeTypedPasswordAction(value)),
              decoration: InputDecoration(
                labelText: 'password',
              ),
            ),
            FilledButton(
              onPressed: () {
                final locked = state.lockingMechanism.locked;
                final isUnlockAllowed = state.lockingMechanism.isUnlockAllowed;
                if (locked && isUnlockAllowed) {
                  return () => dispatch(UnlockApplicationAction());
                }
                return null;
              }(),
              child: Text('unlock'),
            ),
            FilledButton(
              onPressed: () => navigateTo(ResetPasswordPage()),
              child: Text('forgot password'),
            ),
          ],
        ),
      ),
    );
  }
}
