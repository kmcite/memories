import 'package:memories/business/locking_mechanism.dart';
// import 'package:memories/business/reset_password.dart';
import 'package:memories/business/user_profile.dart';
import 'package:memories/main.dart';
import 'package:memories/features/features.dart';

class ResetPasswordPage extends UI {
  const ResetPasswordPage({super.key});

  @override
  Widget build(context) {
    final lockingMechanism = context(lockingMechanismStateProvider);
    return switch (lockingMechanism.resetStatus()) {
      ResetPasswordStatus.verificationEmail => EmailVerification(),
      ResetPasswordStatus.newPassword => NewPasswordUI(),
      ResetPasswordStatus.success => SuccessUI(),
    };
  }
}

class SuccessUI extends UI {
  const SuccessUI({super.key});
  void init() {
    // context.read<ResetPasswordReducer>().startTimer();
  }

  void dispose() {
    // context.read<ResetPasswordReducer>().cancelTimer();
  }

  @override
  Widget build(BuildContext context) {
    final lockingMechanism = context(lockingMechanismStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('successful'),
        leading: Icon(Icons.done, color: Colors.green),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8,
          children: [
            Text(
              'password reset successfully',
              style: TextStyle(fontSize: 32),
            ),
            Text(
              'application will go back to login page in a few moments automatically',
            ),
            FilledButton(
              child: Text('back to login now'),
              onPressed: lockingMechanism.lockApplication,
            ),
          ],
        ),
      ),
    );
  }
}

class NewPasswordUI extends UI {
  const NewPasswordUI({super.key});

  @override
  Widget build(BuildContext context) {
    final lockingMechanism = context(lockingMechanismStateProvider);
    return Scaffold(
      appBar: AppBar(title: Text('input new password'), leading: SizedBox()),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8,
          children: [
            Text('please input your new password'),
            TextFormField(
              initialValue: lockingMechanism.newPassword(),
              onChanged: lockingMechanism.newPassword.set,
              decoration: InputDecoration(labelText: 'new password'),
            ),
            FilledButton(
              child: Text('apply'),
              onPressed: lockingMechanism.newPassword().isNotEmpty
                  ? lockingMechanism.apply
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class EmailVerification extends UI {
  const EmailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final lockingMechanism = context(lockingMechanismStateProvider);
    final userProfile = context(userProfileStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 8,
          children: [
            Text(
              'input your registered email',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              initialValue: userProfile.verificationEmail(),
              onChanged: userProfile.verificationEmail.set,
              decoration: InputDecoration(label: Text('Email')),
            ),
            FilledButton(
              child: Text('Verify Email'),
              onPressed: userProfile.isVerified
                  ? () => lockingMechanism.resetStatus.set(.newPassword)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
