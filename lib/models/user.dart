class User {
  final int id;
  final String name;
  final String email;
  final String password;
  final String enterprise;
  final String properties;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.enterprise,
    required this.properties,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    String? enterprise,
    String? properties,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      enterprise: enterprise ?? this.enterprise,
      properties: properties ?? this.properties,
    );
  }

  static List<User> dummyList() => [
        User(
          id: 1,
          name: 'Admin',
          email: 'admin@apollo.com',
          password: 'admin123',
          enterprise: 'Apollo Corp',
          properties: 'Admin',
        ),
      ];
}