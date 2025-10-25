import 'package:flutter/material.dart';
import 'package:apolo_project/models/lead.dart';
import 'package:apolo_project/screens/add_lead_screen.dart';

class LeadsScreen extends StatefulWidget {
  const LeadsScreen({super.key});

  @override
  State<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends State<LeadsScreen> {
  List<Lead> leads = Lead.dummyList();

  void _addLead(Lead newLead) {
    setState(() {
      leads.add(newLead);
    });
  }

  void _updateLead(Lead updatedLead) {
    setState(() {
      final index = leads.indexWhere((l) => l.id == updatedLead.id);
      if (index != -1) {
        leads[index] = updatedLead;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leads'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          _buildFilterBar(),
          Expanded(
            child: ListView.builder(
              itemCount: leads.length,
              itemBuilder: (context, i) => _buildLeadCard(leads[i], context),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[800]!,
        child: const Icon(Icons.add),
        onPressed: () async {
          final newLead = await Navigator.push<Lead>(
            context,
            MaterialPageRoute(builder: (_) => const AddLeadScreen()),
          );
          if (newLead != null) _addLead(newLead);
        },
      ),
    );
  }

  Widget _buildFilterBar() {
    final filters = ['Todos', 'Novo', 'Em Atendimento', 'Qualificado'];
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: filters.map((filter) {
          final isActive = filter == 'Todos';
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isActive ? Colors.blue[800]! : Colors.grey[300]!,
                foregroundColor: isActive ? Colors.white : Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
              child: Text(filter),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLeadCard(Lead lead, BuildContext context) {
    final statusColor = _getStatusColor(lead.status);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor.withOpacity(0.2),
          child: Icon(Icons.person, color: statusColor),
        ),
        title: Text(lead.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(lead.enterprise),
            Text('${lead.origin} • ${lead.phone}'),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                lead.status,
                style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 4),
            Text('ID: ${lead.id}'),
          ],
        ),
        onTap: () async {
          final updated = await Navigator.push<Lead>(
            context,
            MaterialPageRoute(builder: (_) => AddLeadScreen(leadToEdit: lead)),
          );
          if (updated != null) _updateLead(updated);
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    return switch (status) {
      'Novo' => Colors.orange,
      'Em Atendimento' => Colors.blue,
      'Qualificado' => Colors.green,
      _ => Colors.grey,
    };
  }
}