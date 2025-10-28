import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apolo_project/providers/app_state.dart';
import 'package:apolo_project/models/customer.dart';

class AddCustomerScreen extends StatefulWidget {
  final Customer? customerToEdit;
  const AddCustomerScreen({super.key, this.customerToEdit});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl, _phoneCtrl, _emailCtrl, _enterpriseCtrl, _locationCtrl;

  @override
  void initState() {
    super.initState();
    final c = widget.customerToEdit;
    _nameCtrl = TextEditingController(text: c?.name ?? '');
    _phoneCtrl = TextEditingController(text: c?.phone ?? '');
    _emailCtrl = TextEditingController(text: c?.email ?? '');
    _enterpriseCtrl = TextEditingController(text: c?.enterprise ?? '');
    _locationCtrl = TextEditingController(text: c?.location ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _enterpriseCtrl.dispose();
    _locationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.customerToEdit != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Editar Cliente' : 'Novo Cliente')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _field('Nome', _nameCtrl, true),
              _field('Telefone', _phoneCtrl, true),
              _field('Email', _emailCtrl),
              _field('Empresa', _enterpriseCtrl, true),
              _field('Localização', _locationCtrl, true),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: Text(isEdit ? 'Atualizar' : 'Criar'),
                onPressed: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController ctrl, [bool required = false]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: ctrl,
        decoration: InputDecoration(labelText: '$label${required ? ' *' : ''}', border: OutlineInputBorder()),
        validator: required ? (v) => v?.isEmpty ?? true ? 'Obrigatório' : null : null,
      ),
    );
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final customer = Customer(
        id: widget.customerToEdit?.id ?? DateTime.now().millisecondsSinceEpoch,
        name: _nameCtrl.text,
        phone: _phoneCtrl.text,
        email: _emailCtrl.text.isEmpty ? null : _emailCtrl.text,
        enterprise: _enterpriseCtrl.text,
        location: _locationCtrl.text,
        date: widget.customerToEdit?.date ?? DateTime.now(),
        lgpd: true,
        register: widget.customerToEdit?.register ?? 'CLI${DateTime.now().millisecondsSinceEpoch}',
        latitude: widget.customerToEdit?.latitude,
        longitude: widget.customerToEdit?.longitude,
      );

      if (widget.customerToEdit == null) {
        context.read<AppState>().addCustomer(customer);
      } else {
        context.read<AppState>().updateCustomer(customer);
      }
      Navigator.pop(context);
    }
  }
}