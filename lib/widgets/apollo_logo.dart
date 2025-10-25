import 'package:flutter/material.dart';

class ApolloLogo extends StatelessWidget {
  final double size;
  final bool withGlow;

  const ApolloLogo({
    super.key,
    this.size = 48.0,
    this.withGlow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: withGlow
            ? [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/apollo_logo.png',
          width: size,
          height: size,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [Colors.blue[900]!, Colors.blue[600]!],
              ),
            ),
            child: Icon(
              Icons.home,
              size: size * 0.5,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}