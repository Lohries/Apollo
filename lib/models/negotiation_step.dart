
class NegotiationStep {
  String name;
  List<NegotiationField> fields;

  NegotiationStep({
    required this.name,
    this.fields = const [],
  }) {
    fields = List<NegotiationField>.from(fields);
  }
}

class NegotiationField {
  String label;
  bool required;
  String type;
  List<String> options; // Para 'select'

  NegotiationField({
    required this.label,
    this.required = false,
    this.type = 'text',
    this.options = const [],
  });
}