class Lead {
  final int id;
  final String origin;
  final String enterprise;
  final String? observation;
  final DateTime date;
  final String name;
  final String? email;
  final String cep;
  final String phone;
  final String status;
  final String? register;
  final double? latitude;
  final double? longitude;
  final String? city;

  Lead({
    required this.id,
    required this.origin,
    required this.enterprise,
    this.observation,
    required this.date,
    required this.name,
    this.email,
    required this.cep,
    required this.phone,
    required this.status,
    this.register,
    this.latitude,
    this.longitude,
    this.city,
  });

  static const List<String> statusOptions = ['Novo', 'Em Atendimento', 'Qualificado'];

  static List<Lead> dummyList() {
    return List.generate(5, (i) {
      return Lead(
        id: i + 1,
        origin: ['Site', 'Indicação', 'Evento'][i % 3],
        enterprise: 'Empresa ${i + 1} Ltda',
        observation: i % 2 == 0 ? 'Interessado em solução' : null,
        date: DateTime.now().subtract(Duration(days: i)),
        name: 'Cliente ${i + 1}',
        email: 'cliente${i + 1}@empresa.com',
        cep: '01001-${(i + 1).toString().padLeft(3, '0')}',
        phone: '(11) 9${i + 1}234-5678',
        status: statusOptions[i % statusOptions.length],
        register: 'USR00${i + 1}',
        latitude: -23.5505 + (i * 0.01),
        longitude: -46.6333 + (i * 0.01),
        city: 'São Paulo, SP',
      );
    });
  }

  Lead copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? cep,
    String? observation,
    String? status,
    double? latitude,
    double? longitude,
    String? city,
  }) {
    return Lead(
      id: id ?? this.id,
      origin: origin,
      enterprise: enterprise,
      observation: observation ?? this.observation,
      date: date,
      name: name ?? this.name,
      email: email ?? this.email,
      cep: cep ?? this.cep,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      register: register,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      city: city ?? this.city,
    );
  }
}