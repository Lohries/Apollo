import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apolo_project/providers/app_state.dart';
import 'package:apolo_project/models/lead.dart';

class AddLeadScreen extends StatefulWidget {
  final Lead? leadToEdit;
  const AddLeadScreen({super.key, this.leadToEdit});

  @override
  State<AddLeadScreen> createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<AddLeadScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _enterpriseCtrl;
  late TextEditingController _originCtrl;
  late TextEditingController _cepCtrl;
  late TextEditingController _observationCtrl;
  String _status = Lead.statusOptions[0];

  @override
  void initState() {
    super.initState();
    final lead = widget.leadToEdit;
    _nameCtrl = TextEditingController(text: lead?.name ?? '');
    _emailCtrl = TextEditingController(text: lead?.email ?? '');
    _phoneCtrl = TextEditingController(text: lead?.phone ?? '');
    _enterpriseCtrl = TextEditingController(text: lead?.enterprise ?? '');
    _originCtrl = TextEditingController(text: lead?.origin ?? '');
    _cepCtrl = TextEditingController(text: lead?.cep ?? '');
    _observationCtrl = TextEditingController(text: lead?.observation ?? '');
    _status = lead?.status ?? Lead.statusOptions[0];
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _enterpriseCtrl.dispose();
    _originCtrl.dispose();
    _cepCtrl.dispose();
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
            icon: const Icon(Icons.save),
            onPressed: _save,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _field('Nome', _nameCtrl, true),
              _field('Email', _emailCtrl),
              _field('Telefone', _phoneCtrl, true),
              _field('Empresa', _enterpriseCtrl, true),
              _field('Origem', _originCtrl, true),
              _field('CEP', _cepCtrl, true),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: Lead.statusOptions.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                onChanged: (v) => setState(() => _status = v!),
              ),
              const SizedBox(height: 24),
              _field('Observações', _observationCtrl, false, 3),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  label: Text(isEdit ? 'Atualizar Lead' : 'Criar Lead'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _save,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController ctrl, [bool required = false, int? maxLines]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: ctrl,
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          labelText: '$label${required ? ' *' : ''}',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        validator: required
            ? (value) => value?.trim().isEmpty ?? true ? 'Campo obrigatório' : null
            : null,
      ),
    );
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final lead = Lead(
        id: widget.leadToEdit?.id ?? DateTime.now().millisecondsSinceEpoch,
        name: _nameCtrl.text.trim(),
        email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
        phone: _phoneCtrl.text.trim(),
        enterprise: _enterpriseCtrl.text.trim(),
        origin: _originCtrl.text.trim(),
        cep: _cepCtrl.text.trim(),
        observation: _observationCtrl.text.trim().isEmpty ? null : _observationCtrl.text.trim(),
        status: _status,
        date: widget.leadToEdit?.date ?? DateTime.now(),
        register: widget.leadToEdit?.register,
        latitude: widget.leadToEdit?.latitude,
        longitude: widget.leadToEdit?.longitude,
        city: widget.leadToEdit?.city,
      );

      if (widget.leadToEdit == null) {
        context.read<AppState>().addLead(lead);
      } else {
        context.read<AppState>().updateLead(lead);
      }

      Navigator.pop(context);
    }
  }
}