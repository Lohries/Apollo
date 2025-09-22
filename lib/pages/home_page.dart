import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0; // Track the selected sidebar item
  bool _isExpanded = true; // Track sidebar expanded/collapsed state
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;

  // List of sidebar items
  final List<Map<String, dynamic>> _sidebarItems = [
    {'title': 'Profile', 'icon': Icons.person, 'content': const ProfileContent()},
    {'title': 'Settings', 'icon': Icons.settings, 'content': const SettingsContent()},
    {'title': 'Dashboard', 'icon': Icons.dashboard, 'content': const DashboardContent()},
    {'title': 'Opportunities', 'icon': Icons.work, 'content': const OpportunitiesContent()},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _widthAnimation = Tween<double>(begin: 200, end: 60).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleSidebar() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Página Inicial"),
        actions: [
          IconButton(
            icon: Icon(_isExpanded ? Icons.arrow_back : Icons.arrow_forward),
            onPressed: _toggleSidebar,
          ),
        ],
      ),
      body: Row(
        children: [
          AnimatedBuilder(
            animation: _widthAnimation,
            builder: (context, child) {
              return Container(
                width: _widthAnimation.value,
                color: Colors.grey[200],
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      height: 100,
                      color: Colors.red,
                      child: _isExpanded
                          ? const Center(
                              child: Text(
                                'Menu',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                            )
                          : const Center(child: Icon(Icons.menu, color: Colors.white)),
                    ),
                    ..._sidebarItems.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> item = entry.value;
                      return ListTile(
                        leading: Icon(item['icon']),
                        title: _isExpanded ? Text(item['title']) : null,
                        selected: _selectedIndex == index,
                        onTap: () => _onItemTapped(index),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: _isExpanded ? 16.0 : 12.0,
                        ),
                      );
                    }),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: Center(
              child: _sidebarItems[_selectedIndex]['content'],
            ),
          ),
        ],
      ),
    );
  }
}

// Widgets for each sidebar item's content
class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Profile Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text('Welcome to your profile!', style: TextStyle(fontSize: 18)),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile action triggered!')),
            );
          },
          child: const Text('Edit Profile'),
        ),
      ],
    );
  }
}

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Settings Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text('Adjust your settings here.', style: TextStyle(fontSize: 18)),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Settings action triggered!')),
            );
          },
          child: const Text('Save Settings'),
        ),
      ],
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Dashboard Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text('View your dashboard data.', style: TextStyle(fontSize: 18)),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Dashboard refreshed!')),
            );
          },
          child: const Text('Refresh Dashboard'),
        ),
      ],
    );
  }
}

class OpportunitiesContent extends StatelessWidget {
  const OpportunitiesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Opportunities Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text('Manage your CRM opportunities here.', style: TextStyle(fontSize: 18)),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Opportunities action triggered!')),
            );
          },
          child: const Text('View Opportunities'),
        ),
      ],
    );
  }
}
