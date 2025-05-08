import 'package:flutter/material.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample data for alerts
    final List<Map<String, String>> alerts = [
      {
        "title": "Vehicle A is over-speeding.",
        "type": "speed",
        "time": "2 mins ago"
      },
      {
        "title": "Vehicle B entered restricted area.",
        "type": "location",
        "time": "5 mins ago"
      },
      {
        "title": "Vehicle C's fuel level is low.",
        "type": "fuel",
        "time": "10 mins ago"
      },
    ];

    Icon _getAlertIcon(String type, {double size = 30}) {
      switch (type) {
        case "speed":
          return Icon(Icons.speed, color: Colors.redAccent, size: size);
        case "location":
          return Icon(Icons.location_off, color: Colors.orange, size: size);
        case "fuel":
          return Icon(Icons.local_gas_station, color: Colors.blue, size: size);
        default:
          return Icon(Icons.notification_important, color: Colors.grey, size: size);
      }
    }

    String _getAlertDetails(String type) {
      switch (type) {
        case "speed":
          return "The vehicle has exceeded the speed limit. Immediate action is recommended to ensure driver safety.";
        case "location":
          return "The vehicle has entered a restricted area. Please verify the route and compliance with zone rules.";
        case "fuel":
          return "The vehicle's fuel level is below the threshold. Refueling is advised soon.";
        default:
          return "An important alert regarding vehicle activity has been detected.";
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerts', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0558A7),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          final alert = alerts[index];
          final type = alert["type"] ?? "unknown";

          return Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            margin: const EdgeInsets.symmetric(vertical: 12),
            color: Colors.white,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              leading: CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                child: _getAlertIcon(type),
              ),
              title: Text(
                alert["title"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF0558A7),
                ),
              ),
              subtitle: Text(
                alert["time"]!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    title: Row(
                      children: [
                        _getAlertIcon(type, size: 24),
                        const SizedBox(width: 8),
                        const Text(
                          "Alert Details",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          alert["title"]!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _getAlertDetails(type),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 18, color: Colors.grey),
                            const SizedBox(width: 6),
                            Text(
                              alert["time"]!,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
