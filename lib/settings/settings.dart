import '../main.dart';

class User {
  final String name;
  final String email;
  const User({
    this.name = '',
    this.email = '',
  });

  User copyWith({
    String? name,
    String? email,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: (map['name'] ?? '') as String,
      email: (map['email'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, email];
}

class Settings {
  ThemeMode get themeMode => ThemeMode.values.elementAt(themeModeIndex);
  final int themeModeIndex;
  final String password;
  final int navigationIndex;
  final String inputPassword;
  final User user;
  const Settings({
    this.themeModeIndex = 0,
    this.password = '',
    this.navigationIndex = 0,
    this.inputPassword = '',
    this.user = const User(),
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      themeModeIndex,
      password,
      navigationIndex,
      inputPassword,
      user,
    ];
  }

  Settings copyWith({
    int? themeModeIndex,
    String? password,
    int? navigationIndex,
    String? inputPassword,
    User? user,
  }) {
    return Settings(
      themeModeIndex: themeModeIndex ?? this.themeModeIndex,
      password: password ?? this.password,
      navigationIndex: navigationIndex ?? this.navigationIndex,
      inputPassword: inputPassword ?? this.inputPassword,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'themeModeIndex': themeModeIndex,
      'password': password,
      'navigationIndex': navigationIndex,
      'inputPassword': inputPassword,
      'user': user.toMap(),
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      themeModeIndex: (map['themeModeIndex'] ?? 0) as int,
      password: (map['password'] ?? '') as String,
      navigationIndex: (map['navigationIndex'] ?? 0) as int,
      inputPassword: (map['inputPassword'] ?? '') as String,
      user: User.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Settings.fromJson(String source) =>
      Settings.fromMap(json.decode(source) as Map<String, dynamic>);
}
