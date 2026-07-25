import 'package:memories/main.dart';

final userProfileStateProvider = provider((ref) => UserProfileState());

class UserProfileState extends Notifier {
  late final name = signal('');
  late final email = signal('');
  late final verificationEmail = signal('');
  bool get isVerified => verificationEmail == email;
}
