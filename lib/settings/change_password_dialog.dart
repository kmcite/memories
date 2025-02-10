import 'package:forui/forui.dart';
import 'package:memories/main.dart';

import 'settings_bloc.dart';

class ChangePasswordDialog extends UI {
  const ChangePasswordDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return FDialog(
      title: Text('change password'),
      body: Text('input new password'),
      // actionsAxis: Axis.horizontal,
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
          initialValue: settingsBloc.password,
          onChange: settingsBloc.setPassword,
        ).pad(),
      ],
    );
  }
}
