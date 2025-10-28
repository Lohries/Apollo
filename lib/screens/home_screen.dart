// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apolo_project/theme/theme_provider.dart';
import 'package:apolo_project/screens/dashboard_screen.dart';
import 'package:apolo_project/screens/lead_screen.dart';
import 'package:apolo_project/screens/opportunities_screen.dart';
import 'package:apolo_project/screens/customers_screen.dart';
import 'package:apolo_project/screens/users_screen.dart';
import 'package:apolo_project/screens/add_negotiation_template_screen.dart';

// 1. DECLARAÇÃO PRIMEIRO: ESTADO PÚBLICO
class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const LeadsScreen(),
    const OpportunitiesScreen(),
    const CustomersScreen(),
    const UsersScreen(),
  ];

  final List<String> _titles = [
    'Dashboard',
    'Leads',
    'Oportunidades',
    'Clientes',
    'Usuários',
  ];

  // MÉTODO PÚBLICO PARA MUDAR TELA
  void selectIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
          ),
        ],
      ),
      drawer: _buildSidebar(),
      body: _screens[_selectedIndex],
    );
  }

  Widget _buildSidebar() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.business, size: 40, color: Colors.blue),
                ),
                SizedBox(height: 12),
                Text(
                  'Apollo CRM',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Gerencie seu negócio',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          _sidebarItem(Icons.dashboard, 'Dashboard', 0),
          _sidebarItem(Icons.person, 'Leads', 1),
          _sidebarItem(Icons.handshake, 'Oportunidades', 2),
          _sidebarItem(Icons.business, 'Clientes', 3),
          _sidebarItem(Icons.people, 'Usuários', 4),
          const Divider(height: 32),
          ListTile(
            leading: const Icon(Icons.design_services),
            title: const Text('Criar Modelo Personalizado'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddNegotiationTemplateScreen()),
              );
            },
          ),
          _sidebarItem(
            Icons.logout,
            'Sair',
            -1,
            onTap: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }

  Widget _sidebarItem(IconData icon, String title, int index, {VoidCallback? onTap}) {
    final isSelected = _selectedIndex == index;

    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.blue : null),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.blue : null,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: Colors.blue[50],
      selectedColor: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      onTap: onTap ??
          () {
            if (index >= 0) {
              selectIndex(index);
            }
            Navigator.pop(context);
          },
    );
  }
}

// 2. DEPOIS: WIDGET QUE USA O ESTADO
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}