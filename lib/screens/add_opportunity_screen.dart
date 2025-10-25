import 'package:flutter/material.dart';

class AddOpportunityScreen extends StatefulWidget {
  const AddOpportunityScreen({super.key});

  @override
  State<AddOpportunityScreen> createState() => _AddOpportunityScreenState();
}

class _AddOpportunityScreenState extends State<AddOpportunityScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _valueCtrl = TextEditingController();
  final _clientCtrl = TextEditingController();

  
  @override
  void dispose() {
    _titleCtrl.dispose();
    _valueCtrl.dispose();
    _clientCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Oportunidade'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Oportunidade criada!')),
                );
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // CORRIGIDO: SEM const
              TextFormField(
                controller: _titleCtrl,
                decoration: InputDecoration(
                  labelText: 'Título da Oportunidade *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // SEM const
                  ),
                  filled: true,
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 16),

              // CORRIGIDO: SEM const
              TextFormField(
                controller: _clientCtrl,
                decoration: InputDecoration(
                  labelText: 'Cliente',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // SEM const
                  ),
                  filled: true,
                ),
              ),
              const SizedBox(height: 16),

              // CORRIGIDO: SEM const
              TextFormField(
                controller: _valueCtrl,
                decoration: InputDecoration(
                  labelText: 'Valor Estimado (R\$)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // SEM const
                  ),
                  filled: true,
                  prefixText: 'R\$ ',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // CORRIGIDO: SEM const
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // SEM const
                  ),
                  filled: true,
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Oportunidade criada com sucesso!')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Criar Oportunidade'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}