import 'package:forui/forui.dart';
import 'package:hux/hux.dart';
import 'package:memories/utils/navigator.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../main.dart';

class UserProfile extends StatefulWidget {
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final name = signal('adn');
  final email = signal('adn@gmail.com');

  @override
  Widget build(BuildContext context) {
    return HuxCard(
      title: ('User Profile'),
      subtitle: email(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8,
        children: [
          HuxButton(
            child: Text(name()),
            onPressed: () {},
          ),
          HuxButton(
            onPressed: () {
              navigator.toDialog(UserNameDialog());
            },
            child: Text('update user information'),
          ),
        ],
      ),
    );
  }
}

final focus = FocusNode();

class UserNameDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FDialog(
      actions: [
        FTextField(
          // label: Text('Name'),
          // initialValue: name(),
          // onChanged: name,
          onSubmit: (value) => FocusScope.of(context).requestFocus(focus),
        ),
        FTextField(
          // placeholder: Text('email'),
          // focusNode: focus,
          // initialValue: email(),
          onChange: (email) {},
          onSubmit: (value) => navigator.back(),
        ),
      ],
    );
  }
}
