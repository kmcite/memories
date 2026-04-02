import 'dart:async';

import 'package:memories/business/business.dart';
import 'package:redux/redux.dart';

enum ResetPasswordStatus { verificationEmail, newPassword, success }

class ResetPasswordState {
  ResetPasswordStatus resetStatus = ResetPasswordStatus.verificationEmail;
  String newPassword = '';
}

@override
ResetPasswordState resetPassword(ResetPasswordState state, action) {
  return switch (action) {
    ResetPasswordStatusAction() => state..resetStatus = action.value,
    ResetPasswordNewPasswordAction() => state..newPassword = action.value,
    _ => state,
  };
}

class ResetPasswordAction {
  const ResetPasswordAction();
}

class ResetPasswordStatusAction extends ResetPasswordAction {
  final ResetPasswordStatus value;
  const ResetPasswordStatusAction(this.value);
}

class ResetPasswordNewPasswordAction extends ResetPasswordAction {
  final String value;
  const ResetPasswordNewPasswordAction(this.value);
}

class ResetPasswordMW extends MiddlewareClass<Business> {
  Timer? timer;
  @override
  call(store, action, next) {
    next(action);
  }
}
