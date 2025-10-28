class Negotiation {
  final int id;
  final String enterprise;
  final String users;
  final String serialNumber;
  final double value;
  final DateTime dateStart;
  final DateTime dateFinish;
  final String customer;
  final String xmlFile;
  final String pdfFile;
  final String lastStatus;

  Negotiation({
    required this.id,
    required this.enterprise,
    required this.users,
    required this.serialNumber,
    required this.value,
    required this.dateStart,
    required this.dateFinish,
    required this.customer,
    required this.xmlFile,
    required this.pdfFile,
    required this.lastStatus,
  });
}