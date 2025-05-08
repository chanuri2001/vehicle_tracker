import 'package:flutter/material.dart';
import 'package:vehicle_tracker/models/vehicle.dart';

class VehicleInfoCard extends StatelessWidget {
  final Vehicle vehicle;
  final VoidCallback onClose;

  const VehicleInfoCard({
    super.key,
    required this.vehicle,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  vehicle.vehicleNumber,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0558A7),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: onClose,
                ),
              ],
            ),
            const Divider(thickness: 1, height: 20),
            _buildInfoRow(Icons.location_on, 'Location', vehicle.location),
            _buildInfoRow(Icons.traffic, 'Status', vehicle.status,
                highlight: vehicle.status == 'Active' ? Colors.green : Colors.orange),
            _buildInfoRow(Icons.speed, 'Speed', '${vehicle.speed} km/h'),
            _buildInfoRow(Icons.access_time, 'Last Updated', vehicle.lastUpdated),
            const SizedBox(height: 20),
            // Action Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigate to detailed vehicle info
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text('View Details'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0558A7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value,
      {Color? highlight}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: const Color(0xFF0558A7)),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 15, color: Colors.black87),
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: highlight ?? Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
