import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  final String? vehicleNumberFilter;
  final String? locationFilter;
  final String? statusFilter;
  final Function(String?, String?, String?) onApplyFilter;
  final VoidCallback onClearFilter;

  const FilterBottomSheet({
    Key? key,
    required this.vehicleNumberFilter,
    required this.locationFilter,
    required this.statusFilter,
    required this.onApplyFilter,
    required this.onClearFilter,
  }) : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late TextEditingController _vehicleNumberController;
  late TextEditingController _locationController;
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _vehicleNumberController = TextEditingController(
      text: widget.vehicleNumberFilter ?? '',
    );
    _locationController = TextEditingController(
      text: widget.locationFilter ?? '',
    );
    _selectedStatus = widget.statusFilter;
  }

  @override
  void dispose() {
    _vehicleNumberController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const Center(
                child: Text(
                  'Filter Vehicles',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0558A7),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Vehicle Number
              const Text(
                'Vehicle Number',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _vehicleNumberController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.directions_car),
                  hintText: 'Enter vehicle number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Location
              const Text(
                'Location',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                  hintText: 'Enter location',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Status Dropdown
              const Text(
                'Status',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                items:
                    ['Active', 'Offline', 'Maintenance']
                        .map(
                          (status) => DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          ),
                        )
                        .toList(),
                onChanged: (value) => setState(() => _selectedStatus = value),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.traffic),
                  hintText: 'Select status',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton.icon(
                    icon: const Icon(Icons.clear),
                    label: const Text('Clear'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                    ),
                    onPressed: widget.onClearFilter,
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.filter_alt),
                    label: const Text('Apply Filters'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0558A7),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      widget.onApplyFilter(
                        _vehicleNumberController.text.trim().isEmpty
                            ? null
                            : _vehicleNumberController.text.trim(),
                        _locationController.text.trim().isEmpty
                            ? null
                            : _locationController.text.trim(),
                        _selectedStatus,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
