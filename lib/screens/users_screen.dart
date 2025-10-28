import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apolo_project/providers/app_state.dart';
import 'package:apolo_project/screens/add_user_screen.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final users = context.watch<AppState>().users;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddUserScreen())),
          ),
        ],
      ),
      body: users.isEmpty
          ? const Center(child: Text('Nenhum usuário'))
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, i) {
                final u = users[i];
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person_outline)),
                    title: Text(u.name),
                    subtitle: Text(u.email),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddUserScreen(userToEdit: u))),
                    ),
                  ),
                );
              },
            ),
    );
  }
}