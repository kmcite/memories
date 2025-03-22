import 'package:forui/forui.dart';
import 'package:memories/api/settings_repository.dart';

import '../../main.dart';

mixin UserProfileBloc {
  Modifier<String> get name => settignsRepository.name;
  Modifier<String> get email => settignsRepository.email;
}

class UserProfile extends UI with UserProfileBloc {
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
        email(),
        style: theme.textTheme.bodyMedium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FButton(
            label: Text(
              name(),
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

mixin UserNameBloc {
  final focus = FocusNode();
  Modifier<String> get name => settignsRepository.name;
  Modifier<String> get email => settignsRepository.email;
}

class UserNameDialog extends UI with UserNameBloc {
  @override
  Widget build(BuildContext context) {
    return FDialog(
      actions: [
        FTextField(
          label: Text('Name'),
          initialValue: name(),
          onChange: name,
          onSubmit: (value) => FocusScope.of(context).requestFocus(focus),
        ).pad(),
        FTextField.email(
          // placeholder: Text('email'),
          focusNode: focus,
          initialValue: email(),
          onChange: email,
          onSubmit: (value) => navigator.back(),
        ).pad(),
      ],
    );
  }
}
