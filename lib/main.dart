import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apolo_project/theme/theme_provider.dart';
import 'package:apolo_project/providers/app_state.dart';
import 'package:apolo_project/screens/login_screen.dart';

void main() {
  runApp(const ApolloApp());
}

class ApolloApp extends StatelessWidget {
  const ApolloApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Apollo CRM',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const LoginScreen(),
          );
        },
      ),
    );
  }
}