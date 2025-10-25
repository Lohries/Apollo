import 'package:flutter/material.dart';

class OpportunityDetailScreen extends StatelessWidget {
  final String name;
  final String company;
  final String status;
  final String? value;

  const OpportunityDetailScreen({
    super.key,
    required this.name,
    required this.company,
    required this.status,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.blue[800]!,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.business, color: Colors.white),
                ),
                title: Text(company),
                subtitle: Text('Status: $status'),
                trailing: value != null ? Text('R\$ $value') : null,
              ),
            ),
            const SizedBox(height: 16),
            const Text('Pipeline:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildStage('Novo', Colors.grey),
                const Icon(Icons.arrow_forward, color: Colors.grey),
                _buildStage('Qualificado', Colors.blue),
                const Icon(Icons.arrow_forward, color: Colors.grey),
                _buildStage('Proposta', Colors.orange),
                const Icon(Icons.arrow_forward, color: Colors.grey),
                _buildStage('Fechado', Colors.green),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Atividades:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildActivity('Hoje', 'Reunião de follow-up', '14:30'),
                _buildActivity('Ontem', 'Email de proposta enviado', '10:15'),
                _buildActivity('2 dias atrás', 'Lead qualificado', '16:45'),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[800]!,
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }

  Widget _buildStage(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildActivity(String date, String description, String time) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.blue,
        child: Icon(Icons.schedule, color: Colors.white, size: 20),
      ),
      title: Text(description),
      subtitle: Text('$date • $time'),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}