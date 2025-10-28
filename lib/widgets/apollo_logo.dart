import 'package:flutter/material.dart';

class ApolloLogo extends StatelessWidget {
  final double size;
  final bool withGlow;

  const ApolloLogo({super.key, this.size = 40, this.withGlow = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: withGlow
            ? [BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 12, spreadRadius: 2)]
            : null,
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/apollo_logo.png',
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => CircleAvatar(
            radius: size / 2,
            backgroundColor: Colors.blue[100],
            child: Text('A', style: TextStyle(fontSize: size / 2, color: Colors.blue[800])),
          ),
        ),
      ),
    );
  }
}