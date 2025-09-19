import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _isExpanded = true;
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;

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
    _widthAnimation = Tween<double>(begin: 220, end: 70).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
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
        title: Text(
          'Página Inicial',
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(_isExpanded ? Icons.arrow_back : Icons.arrow_forward),
            onPressed: _toggleSidebar,
            tooltip: _isExpanded ? 'Collapse Sidebar' : 'Expand Sidebar',
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
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(2, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.red[700],
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: Center(
                        child: _isExpanded
                            ? Text(
                                'CRM Menu',
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : const Icon(Icons.menu, color: Colors.white, size: 30),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: _sidebarItems.asMap().entries.map((entry) {
                          int index = entry.key;
                          Map<String, dynamic> item = entry.value;
                          return ListTile(
                            leading: Icon(
                              item['icon'],
                              color: _selectedIndex == index ? Colors.red[700] : Colors.red[300],
                            ),
                            title: _isExpanded
                                ? Text(
                                    item['title'],
                                    style: GoogleFonts.roboto(
                                      color: _selectedIndex == index ? Colors.red[700] : Colors.red[300],
                                      fontWeight: _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  )
                                : null,
                            selected: _selectedIndex == index,
                            selectedTileColor: Colors.red[100],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: _isExpanded ? 16.0 : 12.0,
                              vertical: 8.0,
                            ),
                            onTap: () => _onItemTapped(index),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: _sidebarItems[_selectedIndex]['content'],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Profile Page',
              style: GoogleFonts.roboto(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.red[700],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Welcome to your profile!',
              style: GoogleFonts.roboto(fontSize: 18, color: Colors.grey[800]),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Edit Profile',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Profile action triggered!', style: GoogleFonts.roboto(color: Colors.white)),
                    backgroundColor: Colors.red[700],
                  ),
                );
              },
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Settings Page',
              style: GoogleFonts.roboto(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.red[700],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Adjust your settings here.',
              style: GoogleFonts.roboto(fontSize: 18, color: Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Dashboard Page',
              style: GoogleFonts.roboto(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.red[700],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'View your dashboard data.',
              style: GoogleFonts.roboto(fontSize: 18, color: Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  }
}

class OpportunitiesContent extends StatelessWidget {
  const OpportunitiesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Opportunities Page',
              style: GoogleFonts.roboto(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.red[700],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Manage your CRM opportunities here.',
              style: GoogleFonts.roboto(fontSize: 18, color: Colors.grey[800]),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'View Opportunities',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('View opportunities list!', style: GoogleFonts.roboto(color: Colors.white)),
                    backgroundColor: Colors.red[700],
                  ),
                );
              },
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}