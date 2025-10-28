// lib/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:apolo_project/providers/app_state.dart';
import 'package:apolo_project/screens/add_lead_screen.dart';
import 'package:apolo_project/screens/add_customer_screen.dart';
import 'package:apolo_project/screens/home_screen.dart'; // IMPORTA HomeScreenState

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final leads = appState.leads;
    final customers = appState.customers.length;
    final users = appState.users.length;

    // Contagem por status
    final Map<String, int> statusCount = {
      'Novo': leads.where((l) => l.status == 'Novo').length,
      'Em Atendimento': leads.where((l) => l.status == 'Em Atendimento').length,
      'Qualificado': leads.where((l) => l.status == 'Qualificado').length,
    };

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TÍTULO
            const Text(
              'Dashboard',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // CARDS PRINCIPAIS
            Row(
              children: [
                _buildStatCard(
                  context,
                  title: 'Leads',
                  value: leads.length,
                  icon: Icons.person_outline,
                  color: Colors.blue,
                  onTap: () => _goToScreen(context, 1),
                ),
                const SizedBox(width: 16),
                _buildStatCard(
                  context,
                  title: 'Clientes',
                  value: customers,
                  icon: Icons.business,
                  color: Colors.green,
                  onTap: () => _goToScreen(context, 3),
                ),
                const SizedBox(width: 16),
                _buildStatCard(
                  context,
                  title: 'Usuários',
                  value: users,
                  icon: Icons.people,
                  color: Colors.orange,
                  onTap: () => _goToScreen(context, 4),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // GRÁFICO + LEADS RECENTES
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // GRÁFICO DE PIZZA
                Expanded(
                  flex: 2,
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Status dos Leads',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 200,
                            child: PieChart(
                              PieChartData(
                                sections: _buildPieSections(statusCount),
                                centerSpaceRadius: 40,
                                sectionsSpace: 2,
                                borderData: FlBorderData(show: false),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // LEADS RECENTES
                Expanded(
                  flex: 3,
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Leads Recentes',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                onPressed: () => _goToScreen(context, 1),
                                child: const Text('Ver todos'),
                              ),
                            ],
                          ),
                          const Divider(height: 20),
                          if (leads.isEmpty)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 32),
                              child: Center(child: Text('Nenhum lead cadastrado')),
                            )
                          else
                            ...leads.take(5).map((lead) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 6),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: CircleAvatar(
                                      backgroundColor: _getStatusColor(lead.status),
                                      radius: 18,
                                      child: Text(
                                        lead.name.isNotEmpty ? lead.name[0].toUpperCase() : '?',
                                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    title: Text(
                                      lead.name,
                                      style: const TextStyle(fontWeight: FontWeight.w500),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      '${lead.enterprise} • ${lead.origin}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing: Chip(
                                      label: Text(
                                        lead.status,
                                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                      ),
                                      backgroundColor: _getStatusColor(lead.status).withOpacity(0.2),
                                      labelStyle: TextStyle(color: _getStatusColor(lead.status)),
                                      padding: const EdgeInsets.symmetric(horizontal: 4),
                                    ),
                                  ),
                                )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // AÇÕES RÁPIDAS
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ações Rápidas',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.person_add, size: 20),
                            label: const Text('Novo Lead'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const AddLeadScreen()),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.business, size: 20),
                            label: const Text('Novo Cliente'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const AddCustomerScreen()),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // MÉTODO PARA CONSTRUIR SEÇÕES DO GRÁFICO
  List<PieChartSectionData> _buildPieSections(Map<String, int> statusCount) {
    final List<PieChartSectionData> sections = [];
    final colors = {
      'Novo': Colors.blue,
      'Em Atendimento': Colors.orange,
      'Qualificado': Colors.green,
    };

    statusCount.forEach((status, count) {
      if (count > 0) {
        sections.add(
          PieChartSectionData(
            value: count.toDouble(),
            color: colors[status]!,
            title: '$status\n$count',
            titleStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            radius: 50,
          ),
        );
      }
    });

    return sections;
  }

  // CARD DE ESTATÍSTICA
  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required int value,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Icon(icon, size: 48, color: color),
                const SizedBox(height: 12),
                Text(
                  '$value',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // NAVEGAÇÃO PARA TELA
  void _goToScreen(BuildContext context, int index) {
    final homeState = context.findAncestorStateOfType<HomeScreenState>();
    homeState?.selectIndex(index);
  }

  // COR POR STATUS
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Novo':
        return Colors.blue;
      case 'Em Atendimento':
        return Colors.orange;
      case 'Qualificado':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}