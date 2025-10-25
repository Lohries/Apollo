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
  });

  static const List<String> statusOptions = ['Novo', 'Em Atendimento', 'Qualificado'];

  static List<Lead> dummyList() {
    return List.generate(10, (i) {
      final statusIndex = i % statusOptions.length;
      return Lead(
        id: i + 1,
        origin: ['Site', 'Indicação', 'Evento', 'LinkedIn'][i % 4],
        enterprise: 'Empresa ${i + 1} Ltda',
        observation: i % 3 == 0 ? 'Interessado em solução enterprise' : null,
        date: DateTime.now().subtract(Duration(days: i)),
        name: 'Cliente ${i + 1}',
        email: 'cliente${i + 1}@empresa.com',
        // CORRIGIDO: String(i + 1) → (i + 1).toString()
        cep: '01001-${(i + 1).toString().padLeft(3, '0')}',
        phone: '(11) 9${i + 1}234-5678',
        status: statusOptions[statusIndex],
        register: 'USR00${i + 1}',
      );
    });
  }

  Lead copyWith({
    String? name,
    String? email,
    String? phone,
    String? cep,
    String? observation,
    String? status,
  }) {
    return Lead(
      id: id,
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
    );
  }
}