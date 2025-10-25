import 'package:flutter/material.dart';
import 'package:apolo_project/models/lead.dart';
import 'package:apolo_project/widgets/custom_text_field.dart';

class AddLeadScreen extends StatefulWidget {
  final Lead? leadToEdit;
  const AddLeadScreen({super.key, this.leadToEdit});

  @override
  State<AddLeadScreen> createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<AddLeadScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _originCtrl;
  late TextEditingController _enterpriseCtrl;
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _cepCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _observationCtrl;
  late String _status;

  @override
  void initState() {
    super.initState();
    final lead = widget.leadToEdit;
    _originCtrl = TextEditingController(text: lead?.origin ?? '');
    _enterpriseCtrl = TextEditingController(text: lead?.enterprise ?? '');
    _nameCtrl = TextEditingController(text: lead?.name ?? '');
    _emailCtrl = TextEditingController(text: lead?.email ?? '');
    _cepCtrl = TextEditingController(text: lead?.cep ?? '');
    _phoneCtrl = TextEditingController(text: lead?.phone ?? '');
    _observationCtrl = TextEditingController(text: lead?.observation ?? '');
    _status = lead?.status ?? Lead.statusOptions[0];
  }

  @override
  void dispose() {
    _originCtrl.dispose();
    _enterpriseCtrl.dispose();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _cepCtrl.dispose();
    _phoneCtrl.dispose();
    _observationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.leadToEdit != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Editar Lead' : 'Novo Lead'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveLead,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CustomTextField(
                label: 'Origem',
                hintText: 'Como encontrou a empresa?',
                controller: _originCtrl,
                required: true,
              ),
              CustomTextField(
                label: 'Empresa',
                hintText: 'Nome da empresa',
                controller: _enterpriseCtrl,
                required: true,
              ),
              CustomTextField(
                label: 'Nome',
                hintText: 'Nome do contato',
                controller: _nameCtrl,
                required: true,
              ),
              CustomTextField(
                label: 'Email',
                hintText: 'email@exemplo.com',
                controller: _emailCtrl,
              ),
              CustomTextField(
                label: 'CEP',
                hintText: '00000-000',
                controller: _cepCtrl,
                required: true,
              ),
              CustomTextField(
                label: 'Telefone',
                hintText: '(11) 99999-9999',
                controller: _phoneCtrl,
                required: true,
              ),
              const SizedBox(height: 16),

              // CORRIGIDO: REMOVIDO `const` do InputDecoration
              DropdownButtonFormField<String>(
                value: _status,
                decoration: InputDecoration(
                  labelText: 'Status *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                ),
                items: Lead.statusOptions
                    .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                    .toList(),
                onChanged: (value) => setState(() => _status = value!),
              ),

              const SizedBox(height: 16),

              // CORRIGIDO: REMOVIDO `const` do InputDecoration
              TextFormField(
                controller: _observationCtrl,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Observações',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  alignLabelWithHint: true,
                ),
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveLead,
                  child: Text(isEdit ? 'Atualizar Lead' : 'Criar Lead'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveLead() {
    if (_formKey.currentState!.validate()) {
      final lead = Lead(
        id: widget.leadToEdit?.id ?? DateTime.now().millisecondsSinceEpoch ~/ 1000,
        origin: _originCtrl.text,
        enterprise: _enterpriseCtrl.text,
        name: _nameCtrl.text,
        email: _emailCtrl.text.isEmpty ? null : _emailCtrl.text,
        cep: _cepCtrl.text,
        phone: _phoneCtrl.text,
        status: _status,
        observation: _observationCtrl.text.isEmpty ? null : _observationCtrl.text,
        date: widget.leadToEdit?.date ?? DateTime.now(),
        register: widget.leadToEdit?.register,
      );
      Navigator.pop(context, lead);
    }
  }
}