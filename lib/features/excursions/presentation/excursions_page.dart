import 'package:flutter/material.dart';

class ExcursionsPage extends StatelessWidget {
  const ExcursionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Excursions')),
      body: const Center(
        child: Text('Excursions calendar will be added here.'),
      ),
    );
  }
}
