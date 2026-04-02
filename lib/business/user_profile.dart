class UserProfileState {
  String name = '';
  String email = '';
  String verificationEmail = '';
  bool get isVerified => verificationEmail == email;
}

UserProfileState userProfile(UserProfileState state, action) {
  return switch (action) {
    UserProfileNameAction() => state..name = action.name,
    UserProfileEmailAction() => state..email = action.email,
    UserProfileEmailVerificationAction() =>
      state..verificationEmail = action.verificationEmail,
    _ => state,
  };
}

class UserProfileAction {}

class UserProfileNameAction extends UserProfileAction {
  final String name;
  UserProfileNameAction(this.name);
}

class UserProfileEmailAction extends UserProfileAction {
  final String email;
  UserProfileEmailAction(this.email);
}

class UserProfileEmailVerificationAction extends UserProfileAction {
  final String verificationEmail;
  UserProfileEmailVerificationAction(this.verificationEmail);
}
