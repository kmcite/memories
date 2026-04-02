import 'package:memories/business/business.dart';
import 'package:memories/business/navigation.dart';
import 'package:memories/features/memories/memories_page.dart';
import 'package:memories/features/startup/locked_page.dart';
import 'package:memories/main.dart';
import 'package:redux/redux.dart';

class LockingMechanismState {
  bool locked = false;
  String password = '';
  String typedPassword = '';
  bool get isUnlockAllowed => password == typedPassword;
}

LockingMechanismState lockingMechanism(LockingMechanismState state, action) {
  switch (action) {
    case LockApplicationAction():
      return state..locked = true;
    case UnlockApplicationAction():
      return state..locked = false;
    case ChangeTypedPasswordAction():
      return state..typedPassword = action.typedPassword;
    case ChangePasswordAction():
      return state..password = action.password;
    default:
      return state;
  }
}

class LockingMechanismMW extends MiddlewareClass<Business> {
  @override
  call(store, action, next) {
    next(action);
    switch (action) {
      case LockApplicationAction():
        navigator.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LockedPage()),
          (route) => false,
        );
        break;
      case UnlockApplicationAction():
        navigator.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MemoriesPage()),
          (route) => false,
        );
        break;
      default:
        break;
    }
  }
}

class LockingMechanismAction {}

class LockApplicationAction extends LockingMechanismAction {}

class UnlockApplicationAction extends LockingMechanismAction {}

class ChangeTypedPasswordAction extends LockingMechanismAction {
  final String typedPassword;
  ChangeTypedPasswordAction(this.typedPassword);
}

class ChangePasswordAction extends LockingMechanismAction {
  final String password;
  ChangePasswordAction(this.password);
}
