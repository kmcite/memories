import 'package:forui/forui.dart';

import '../main.dart';
import 'settings_bloc.dart';

class UserProfile extends UI {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FCard(
      title: Text('user profile'),
      // leading: CircleAvatar(
      //   backgroundColor: theme.colorScheme.primary,
      //   child: Text(
      //     settingsBloc.name.isNotEmpty
      //         ? settingsBloc.name.characters.first.toUpperCase()
      //         : '',
      //     style: TextStyle(color: theme.colorScheme.onPrimary),
      //   ),
      // ),
      subtitle: Text(
        settingsBloc.email,
        style: theme.textTheme.bodyMedium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FButton(
            label: Text(
              settingsBloc.name,
            ),
            onPress: () {},
          ),
          FButton(
            onPress: () {
              RM.navigate.toDialog(UserNameDialog());
            },
            label: Text('update user informations'),
          ),
        ],
      ),
    ).pad();
  }
}

class UserNameDialog extends UI {
  final focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return FDialog(
      actions: [
        FTextField(
          // placeholder: Text('name'),
          initialValue: settingsBloc.name,
          onChange: settingsBloc.setName,
          // onSubmitted: (value) => FocusScope.of(context).requestFocus(focus),
        ).pad(),
        FTextField(
          // placeholder: Text('email'),
          focusNode: focus,
          initialValue: settingsBloc.email,
          onChange: settingsBloc.setEmail,
          // onSubmitted: (value) => navigator.back(),
        ).pad(),
      ],
    );
  }
}
