import 'package:flutter/material.dart';
import 'package:apolo_project/models/lead.dart';

class LeadDetailScreen extends StatefulWidget {
  final Lead lead;
  const LeadDetailScreen({super.key, required this.lead});
  @override
  State<LeadDetailScreen> createState() => _LeadDetailScreenState();
}

class _LeadDetailScreenState extends State<LeadDetailScreen> {
  late TextEditingController _nameCtrl, _emailCtrl, _phoneCtrl, _cepCtrl, _obsCtrl;
  String? _status;

  final _statuses = ['New', 'Qualified', 'In Progress', 'Won', 'Lost'];

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.lead.name);
    _emailCtrl = TextEditingController(text: widget.lead.email ?? '');
    _phoneCtrl = TextEditingController(text: widget.lead.phone);
    _cepCtrl = TextEditingController(text: widget.lead.cep);
    _obsCtrl = TextEditingController(text: widget.lead.observation ?? '');
    _status = widget.lead.status;
  }

  @override
  void dispose() {
    _nameCtrl.dispose(); _emailCtrl.dispose(); _phoneCtrl.dispose(); _cepCtrl.dispose(); _obsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lead #${widget.lead.id}'),
        backgroundColor: Colors.blue[800]!,
        actions: [IconButton(icon: const Icon(Icons.save), onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lead salvo!')));
          Navigator.pop(context);
        })],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _info('Origem', widget.lead.origin),
            _info('Empresa', widget.lead.enterprise),
            _info('Data', _fmt(widget.lead.date)),
            _info('Registro', widget.lead.register ?? '—'),
            const SizedBox(height: 20),
            _field('Nome', _nameCtrl),
            _field('Email', _emailCtrl),
            _field('Telefone', _phoneCtrl),
            _field('CEP', _cepCtrl),
            const SizedBox(height: 16),
            const Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButtonFormField<String>(
              value: _status,
              items: _statuses.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (v) => setState(() => _status = v),
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: _obsCtrl, maxLines: 4, decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Digite aqui...')),
          ],
        ),
      ),
    );
  }

  Widget _info(String label, String value) => Card(
        child: ListTile(title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(value)),
      );

  Widget _field(String label, TextEditingController ctrl) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: TextField(
          controller: ctrl,
          decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        ),
      );

  String _fmt(DateTime d) => '${d.day}/${d.month}/${d.year} ${d.hour}:${d.minute}';
}