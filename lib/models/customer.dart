class Customer {
  final int id;
  final String name;
  final String phone;
  final String? email;
  final String enterprise;
  final String location;
  final DateTime date;
  final bool lgpd;
  final String register;
  final double? latitude;
  final double? longitude;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    required this.enterprise,
    required this.location,
    required this.date,
    required this.lgpd,
    required this.register,
    this.latitude,
    this.longitude,
  });

  Customer copyWith({
    int? id,
    String? name,
    String? phone,
    String? email,
    String? enterprise,
    String? location,
    DateTime? date,
    bool? lgpd,
    String? register,
    double? latitude,
    double? longitude,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      enterprise: enterprise ?? this.enterprise,
      location: location ?? this.location,
      date: date ?? this.date,
      lgpd: lgpd ?? this.lgpd,
      register: register ?? this.register,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  static List<Customer> dummyList() => [
        Customer(
          id: 1,
          name: 'Maria Silva',
          phone: '(11) 98765-4321',
          email: 'maria@empresa.com',
          enterprise: 'Global Tech',
          location: 'São Paulo, SP',
          date: DateTime.now(),
          lgpd: true,
          register: 'CLI001',
        ),
      ];
}