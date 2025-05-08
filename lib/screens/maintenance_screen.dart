// maintenance_screen.dart
import 'package:flutter/material.dart';

class MaintenanceScreen extends StatelessWidget {
  final List<String> alerts = [
    'Engine check for ABC-1234',
    'Low fuel on XYZ-5678',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Maintenance Alerts')),
      body: ListView.builder(
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.warning, color: Colors.red),
            title: Text(alerts[index]),
          );
        },
      ),
    );
  }
}
