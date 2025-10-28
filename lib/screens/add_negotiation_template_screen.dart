import 'package:flutter/material.dart';
import 'package:apolo_project/models/negotiation_step.dart';
import 'package:apolo_project/widgets/apollo_logo.dart';

class AddNegotiationTemplateScreen extends StatefulWidget {
  const AddNegotiationTemplateScreen({super.key});

  @override
  State<AddNegotiationTemplateScreen> createState() => _AddNegotiationTemplateScreenState();
}

class _AddNegotiationTemplateScreenState extends State<AddNegotiationTemplateScreen> {
  List<NegotiationStep> _steps = [NegotiationStep(name: 'Passo 1')]; // INICIA COM 1
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  void _addStep() {
    setState(() {
      _steps.add(NegotiationStep(name: 'Passo ${_steps.length + 1}'));
      if (_currentStep == _steps.length - 2) _currentStep++;
    });
  }

  void _addFieldToStep(int stepIndex) {
    setState(() {
      _steps[stepIndex].fields.add(NegotiationField(label: 'Campo novo'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Modelo de Negociação'),
        leading: const ApolloLogo(size: 40, withGlow: false),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Modelo salvo!')),
              );
              Navigator.pop(context, _steps);
            },
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: step.name,
                    decoration: const InputDecoration(labelText: 'Nome do Passo'),
                    onChanged: (v) => setState(() => step.name = v),
                  ),
                  const SizedBox(height: 16),
                  const Text('Campos do Passo:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ...step.fields.asMap().entries.map((f) {
                    final fieldIndex = f.key;
                    final field = f.value;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: field.label,
                              decoration: const InputDecoration(labelText: 'Label do Campo'),
                              onChanged: (v) => setState(() => step.fields[fieldIndex].label = v),
                            ),
                          ),
                          Checkbox(
                            value: field.required,
                            onChanged: (v) => setState(() => step.fields[fieldIndex].required = v!),
                          ),
                          const Text('Obrigatório'),
                          DropdownButton<String>(
                            value: field.type,
                            onChanged: (v) => setState(() => step.fields[fieldIndex].type = v!),
                            items: const [
                              DropdownMenuItem(value: 'text', child: Text('Texto')),
                              DropdownMenuItem(value: 'number', child: Text('Número')),
                              DropdownMenuItem(value: 'file', child: Text('Anexo')),
                              DropdownMenuItem(value: 'select', child: Text('Seleção')),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Adicionar Campo'),
                    onPressed: () => _addFieldToStep(index),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addStep,
        child: const Icon(Icons.add),
      ),
    );
  }
}