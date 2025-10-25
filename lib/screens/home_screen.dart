import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apolo_project/screens/lead_screen.dart';
import 'package:apolo_project/screens/opportunities_screen.dart';
import 'package:apolo_project/theme/theme_provider.dart';
import 'package:apolo_project/widgets/apollo_logo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<String> _titles = [
    'Leads',
    'Clientes',
    'Oportunidades',
    'Gestão de Pedidos',
    'Dashboard'
  ];
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const LeadsScreen(),
      const Center(child: Text('Clientes', style: TextStyle(fontSize: 24))),
      const OpportunitiesScreen(),
      const Center(child: Text('Gestão de Pedidos', style: TextStyle(fontSize: 24))),
      const Center(child: Text('Dashboard', style: TextStyle(fontSize: 24))),
    ];
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: () => themeProvider.toggleTheme(),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1976D2), Color(0xFF1565C0)],
                ),
              ),
              child: Row(
                children: const [
                  ApolloLogo(size: 50),
                  SizedBox(width: 16),
                  Text(
                    'APOLLO CRM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ..._titles.asMap().entries.map((e) {
              return ListTile(
                title: Text(e.value),
                selected: _selectedIndex == e.key,
                selectedTileColor: Colors.blue[50],
                onTap: () {
                  _onItemTapped(e.key);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
    );
  }
}