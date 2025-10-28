import 'package:flutter/material.dart';

import 'package:apolo_project/screens/add_opportunity_screen.dart';

class OpportunitiesScreen extends StatelessWidget {
  const OpportunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Oportunidades', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Criar Oportunidade'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddOpportunityScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}