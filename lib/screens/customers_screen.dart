import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apolo_project/providers/app_state.dart';
import 'package:apolo_project/screens/add_customer_screen.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customers = context.watch<AppState>().customers;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddCustomerScreen())),
          ),
        ],
      ),
      body: customers.isEmpty
          ? const Center(child: Text('Nenhum cliente'))
          : ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, i) {
                final c = customers[i];
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.business)),
                    title: Text(c.name),
                    subtitle: Text(c.enterprise),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddCustomerScreen(customerToEdit: c))),
                    ),
                  ),
                );
              },
            ),
    );
  }
}