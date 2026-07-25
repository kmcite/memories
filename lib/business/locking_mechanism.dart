import 'package:memories/business/navigation.dart';
import 'package:memories/features/memories/memories_page.dart';
import 'package:memories/features/startup/locked_page.dart';
import 'package:memories/main.dart';

final lockingMechanismStateProvider = provider(
  (ref) => LockingMechanismState(),
);

class LockingMechanismState extends Notifier {
  late final ValueNotifier<bool> locked = signal(false)
    ..addListener(() {
      if (locked())
        navigator.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LockedPage()),
          (route) => false,
        );
      else
        navigator.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MemoriesPage()),
          (route) => false,
        );
    });
  late final password = signal('');
  late final typedPassword = signal('');

  bool get isUnlockAllowed => password() == typedPassword();

  void lockApplication() {
    locked((_) => true);
  }

  void unlockApplication() {
    locked((_) => false);
  }

  late final resetStatus = signal(ResetPasswordStatus.verificationEmail);
  late final newPassword = signal('');

  void apply() {
    password.set(newPassword());
    newPassword.set('');
    resetStatus.set(.success);
  }
}

enum ResetPasswordStatus { verificationEmail, newPassword, success }
