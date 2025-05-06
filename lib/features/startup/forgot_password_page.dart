import 'dart:async';

import 'package:forui/forui.dart';
import 'package:memories/domain/api/settings_repository.dart';
import 'package:memories/main.dart';

enum ResetPasswordStatus { verificationEmail, newPassword, success }

final ResetPasswordBloc resetBloc = ResetPasswordBloc();

class ResetPasswordBloc {
  bool get isVerified => settignsRepository.email() == verificationEmail;

  String get verificationEmail => verificationEmailRM.state;
  final verificationEmailRM = RM.inject(() => '');
  void setVerificationEmail(String value) => verificationEmailRM.state = value;

  String get newPassword => newPasswordRM.state;
  final newPasswordRM = RM.inject(() => '');
  void setNewPassword(String value) => newPasswordRM.state = value;

  final resetStatusRM = RM.inject(() => ResetPasswordStatus.verificationEmail);
  ResetPasswordStatus get resetStatus => resetStatusRM.state;
  void setResetStatus(ResetPasswordStatus value) => resetStatusRM.state = value;

  Timer? timer;

  void startTimer() {
    timer = Timer(3.seconds, backManually);
  }

  void cancelTimer() {
    timer?.cancel();
    timer = null;
  }

  void backManually() {
    navigator.back();
    cancelTimer();
  }

  void applyNewPassword() {
    setResetStatus(ResetPasswordStatus.success);

    /// bloc to bloc dependencies -> now allowed
    /// will create repo for settings then refactor
    // settingsBloc.setPassword(newPassword);
    settignsRepository.password(newPassword);
  }
}

class ResetPasswordPage extends UI {
  const ResetPasswordPage({super.key});

  @override
  Widget build(context) {
    return switch (resetBloc.resetStatus) {
      ResetPasswordStatus.verificationEmail => EmailVerification(),
      ResetPasswordStatus.newPassword => NewPasswordUI(),
      ResetPasswordStatus.success => SuccessUI(),
    };
  }
}

class SuccessUI extends UI {
  const SuccessUI({super.key});
  @override
  void didMountWidget(context) {
    super.didMountWidget(context);
    resetBloc.startTimer();
  }

  @override
  void didUnmountWidget() {
    resetBloc.cancelTimer();
    super.didUnmountWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'succesful'.text(),
        leading: Icon(Icons.done, color: Colors.green),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('password reset successfully').pad(),
          Text(
            'application will go back to login page in a few moments automatically',
          ).pad(),
          FButton(
            label: 'back to login now'.text(),
            onPress: resetBloc.backManually,
          ).pad(),
        ],
      ).pad(),
    );
  }
}

class NewPasswordUI extends UI {
  const NewPasswordUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: 'input new password'.text(), leading: SizedBox()),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('please input your new password').pad(),
          FTextField(
            initialValue: resetBloc.newPasswordRM.state,
            onChange: resetBloc.setNewPassword,
            // placeholder: Text('new password'),
          ).pad(),
          FButton(
            label: 'apply'.text(),
            onPress: resetBloc.applyNewPassword,
          ).pad(),
        ],
      ),
    );
  }
}

class EmailVerification extends UI {
  const EmailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        prefixActions: [
          FButton.icon(
            onPress: navigator.back,
            child: FIcon(FAssets.icons.arrowLeft),
          ),
        ],
        title: 'Email Verification'.text(),
      ),
      content: Column(
        children: [
          Text(
            'input your registered email',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ).pad(),
          FTextField(
            initialValue: resetBloc.verificationEmailRM.state,
            onChange: resetBloc.setVerificationEmail,
            label: Text('Email'),
          ).pad(),
          FButton(
            label: 'Verify Email'.text(),
            onPress: resetBloc.isVerified
                ? () => resetBloc.setResetStatus(
                      ResetPasswordStatus.newPassword,
                    )
                : null,
          ).pad(),
        ],
      ),
    );
  }
}
