import 'package:forui/forui.dart';
import 'package:memories/main.dart';

mixin ChangePasswordBloc {
  Modifier<String> get password => ([_]) => '';
}

class ChangePasswordDialog extends UI with ChangePasswordBloc {
  const ChangePasswordDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return FDialog(
      title: Text('change password'),
      body: Text('input new password'),
      actions: [
        Expanded(
          child: FButton(
            onPress: () => navigator.back(),
            label: Text('cancel'),
          ),
        ),
        Expanded(
          child: FButton(
            onPress: () => navigator.back(),
            label: Text('apply'),
          ),
        ),
        FTextField(
          obscureText: true,
          initialValue: password(),
          onChange: password,
        ).pad(),
      ],
    );
  }
}
