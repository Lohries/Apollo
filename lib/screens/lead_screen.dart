import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apolo_project/providers/app_state.dart';
import 'package:apolo_project/screens/add_lead_screen.dart';

class LeadsScreen extends StatelessWidget {
  const LeadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final leads = context.watch<AppState>().leads;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leads'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddLeadScreen())),
          ),
        ],
      ),
      body: leads.isEmpty
          ? const Center(child: Text('Nenhum lead'))
          : ListView.builder(
              itemCount: leads.length,
              itemBuilder: (context, i) {
                final lead = leads[i];
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(lead.name),
                    subtitle: Text('${lead.enterprise} • ${lead.status}'),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 'edit') {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => AddLeadScreen(leadToEdit: lead)));
                        } else if (value == 'qualify') {
                          context.read<AppState>().qualifyLeadAsCustomer(lead);
                        }
                      },
                      itemBuilder: (_) => [
                        const PopupMenuItem(value: 'edit', child: Text('Editar')),
                        const PopupMenuItem(value: 'qualify', child: Text('Qualificar')),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}