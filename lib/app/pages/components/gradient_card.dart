import 'package:flutter/material.dart';

class GradientCard extends StatelessWidget {
  const GradientCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 480,
        minWidth: 250,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 2, 38, 68),
            Color.fromARGB(255, 151, 189, 238),
            Color.fromARGB(255, 151, 189, 238),
            Color.fromARGB(255, 151, 189, 238),
            Color.fromARGB(255, 75, 158, 226),
            Color.fromARGB(255, 2, 38, 68),
          ],
        ),
      ),
      child: child,
    );
  }
}
