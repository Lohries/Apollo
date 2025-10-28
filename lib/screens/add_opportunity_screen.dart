// lib/screens/add_opportunity_screen.dart
import 'package:flutter/material.dart';
import 'package:apolo_project/models/opportunity.dart';
import 'package:apolo_project/models/negotiation_step.dart'; // IMPORT NECESSÁRIO

class AddOpportunityScreen extends StatefulWidget {
  const AddOpportunityScreen({super.key});

  @override
  State<AddOpportunityScreen> createState() => _AddOpportunityScreenState();
}

class _AddOpportunityScreenState extends State<AddOpportunityScreen> {
  final _formKey = GlobalKey<FormState>();
  List<NegotiationStep> _steps = Opportunity.defaultTemplate();
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Oportunidade'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveOpportunity,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < _steps.length - 1) {
              setState(() => _currentStep++);
            } else {
              _saveOpportunity();
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() => _currentStep--);
            }
          },
          steps: _steps.asMap().entries.map((e) {
            final index = e.key;
            final step = e.value;
            return Step(
              title: Text(step.name),
              content: Column(
                children: step.fields.map((field) {
                  if (field.type == 'select') {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: '${field.label}${field.required ? ' *' : ''}',
                          border: const OutlineInputBorder(),
                        ),
                        items: field.options
                            .map((opt) => DropdownMenuItem(value: opt, child: Text(opt)))
                            .toList(),
                        onChanged: (v) {},
                        validator: field.required
                            ? (v) => v == null ? 'Selecione uma opção' : null
                            : null,
                      ),
                    );
                  } else if (field.type == 'file') {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.attach_file),
                        label: Text('${field.label}${field.required ? ' *' : ''}'),
                        onPressed: () {
                          // Futuro: abrir galeria
                        },
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        keyboardType: field.type == 'number'
                            ? TextInputType.number
                            : TextInputType.text,
                        decoration: InputDecoration(
                          labelText: '${field.label}${field.required ? ' *' : ''}',
                          border: const OutlineInputBorder(),
                        ),
                        validator: field.required
                            ? (v) => v?.isEmpty ?? true ? 'Obrigatório' : null
                            : null,
                      ),
                    );
                  }
                }).toList(),
              ),
              isActive: _currentStep == index,
              state: _currentStep > index ? StepState.complete : StepState.indexed,
            );
          }).toList(),
        ),
      ),
    );
  }

  void _saveOpportunity() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Oportunidade criada com sucesso!')),
      );
      Navigator.pop(context);
    }
  }
}