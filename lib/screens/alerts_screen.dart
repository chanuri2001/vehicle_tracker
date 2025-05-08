import 'package:flutter/material.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({Key? key}) : super(key: key);

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  // Sample data for alerts
  final List<Map<String, String>> allAlerts = [
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
    {
      "title": "Vehicle D is over-speeding.",
      "type": "speed",
      "time": "15 mins ago"
    },
    {
      "title": "Vehicle E's engine temperature is high.",
      "type": "maintenance",
      "time": "20 mins ago"
    },
    {
      "title": "Vehicle F entered no-entry zone.",
      "type": "location",
      "time": "25 mins ago"
    },
  ];

  String _currentFilter = "all"; // Default filter shows all alerts
  final List<String> filterOptions = [
    "all",
    "speed",
    "location",
    "fuel",
    "maintenance"
  ];

  List<Map<String, String>> get filteredAlerts {
    if (_currentFilter == "all") {
      return allAlerts;
    }
    return allAlerts.where((alert) => alert["type"] == _currentFilter).toList();
  }

  Icon _getAlertIcon(String type, {double size = 30}) {
    switch (type) {
      case "speed":
        return Icon(Icons.speed, color: Colors.redAccent, size: size);
      case "location":
        return Icon(Icons.location_off, color: Colors.orange, size: size);
      case "fuel":
        return Icon(Icons.local_gas_station, color: Colors.blue, size: size);
      case "maintenance":
        return Icon(Icons.engineering, color: Colors.purple, size: size);
      default:
        return Icon(Icons.notification_important,
            color: Colors.grey, size: size);
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
      case "maintenance":
        return "The vehicle's engine temperature is above normal levels. Service check recommended.";
      default:
        return "An important alert regarding vehicle activity has been detected.";
    }
  }

  String _getFilterDisplayName(String filter) {
    switch (filter) {
      case "all":
        return "All Alerts";
      case "speed":
        return "Speed Alerts";
      case "location":
        return "Location Alerts";
      case "fuel":
        return "Fuel Alerts";
      case "maintenance":
        return "Maintenance Alerts";
      default:
        return filter;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerts and Notifications', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0558A7),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: DropdownButtonFormField<String>(
              value: _currentFilter,
              decoration: InputDecoration(
                labelText: "Filter by",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
              items: filterOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(_getFilterDisplayName(value)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _currentFilter = newValue ?? "all";
                });
              },
            ),
          ),
          Expanded(
            child: filteredAlerts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_off,
                            size: 60, color: Colors.grey.shade400),
                        const SizedBox(height: 16),
                        Text(
                          "No alerts found",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Try changing the filter",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredAlerts.length,
                    itemBuilder: (context, index) {
                      final alert = filteredAlerts[index];
                      final type = alert["type"] ?? "unknown";

                      return Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        color: Colors.white,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 18),
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
                          trailing: const Icon(Icons.arrow_forward_ios,
                              size: 18, color: Colors.grey),
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
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
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
                                        const Icon(Icons.access_time,
                                            size: 18, color: Colors.grey),
                                        const SizedBox(width: 6),
                                        Text(
                                          alert["time"]!,
                                          style:
                                              const TextStyle(color: Colors.grey),
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
          ),
        ],
      ),
    );
  }
}