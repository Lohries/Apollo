// lib/screens/add_user_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apolo_project/providers/app_state.dart';
import 'package:apolo_project/models/user.dart';

class AddUserScreen extends StatefulWidget {
  final User? userToEdit;
  const AddUserScreen({super.key, this.userToEdit});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _passwordCtrl;
  late TextEditingController _enterpriseCtrl;

  @override
  void initState() {
    super.initState();
    final u = widget.userToEdit;
    _nameCtrl = TextEditingController(text: u?.name ?? '');
    _emailCtrl = TextEditingController(text: u?.email ?? '');
    _passwordCtrl = TextEditingController(text: u?.password ?? '');
    _enterpriseCtrl = TextEditingController(text: u?.enterprise ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _enterpriseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.userToEdit != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Editar Usuário' : 'Novo Usuário'),
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
              _field('Email', _emailCtrl, true),
              _field('Senha', _passwordCtrl, true), // AGORA FUNCIONA!
              _field('Empresa', _enterpriseCtrl, true),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.person_add),
                  label: Text(isEdit ? 'Atualizar Usuário' : 'Criar Usuário'),
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

  // MÉTODO _field CORRIGIDO: ACEITA obscure
  Widget _field(
    String label,
    TextEditingController ctrl, [
    bool required = false,
    bool obscure = false, // AGORA ACEITA obscure
  ]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: ctrl,
        obscureText: obscure, // CORRETO: obscureText no TextFormField
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

  // MÉTODO SALVAR
  void _save() {
    if (_formKey.currentState!.validate()) {
      final user = User(
        id: widget.userToEdit?.id ?? DateTime.now().millisecondsSinceEpoch,
        name: _nameCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text,
        enterprise: _enterpriseCtrl.text.trim(),
        properties: 'Usuário',
      );

      if (widget.userToEdit == null) {
        context.read<AppState>().addUser(user);
      } else {
        context.read<AppState>().updateUser(user);
      }

      Navigator.pop(context);
    }
  }
}