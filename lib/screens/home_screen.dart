import 'package:flutter/material.dart';
import 'package:vehicle_tracker/models/vehicle.dart';
import 'package:vehicle_tracker/services/vehicle_service.dart';
import 'package:vehicle_tracker/widgets/filter_bottom_sheet.dart';
import 'package:vehicle_tracker/widgets/vehicle_info_card.dart';
import 'profile_screen.dart';
import 'alerts_screen.dart';
import 'dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final VehicleService _vehicleService = VehicleService();
  List<Vehicle> _vehicles = [];
  List<Vehicle> _filteredVehicles = [];
  bool _isLoading = true;
  bool _showStatusPanel = false;
  Vehicle? _selectedVehicle;
  bool _showDevicesList = true;
  bool _showVehicleNumbers = false;
  bool _expandedDevicesList = false;

  String? _vehicleNumberFilter;
  String? _locationFilter;
  String? _statusFilter;

  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final ScrollController _statusDetailsScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadVehicles();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _statusDetailsScrollController.dispose();
    super.dispose();
  }

  Future<void> _loadVehicles() async {
    setState(() => _isLoading = true);
    final vehicles = await _vehicleService.getVehicles();
    setState(() {
      _vehicles = vehicles;
      _filteredVehicles = vehicles;
      _isLoading = false;
    });
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => FilterBottomSheet(
            vehicleNumberFilter: _vehicleNumberFilter,
            locationFilter: _locationFilter,
            statusFilter: _statusFilter,
            onApplyFilter: (vehicleNumber, location, status) {
              setState(() {
                _vehicleNumberFilter = vehicleNumber;
                _locationFilter = location;
                _statusFilter = status;
                _applyFilters();
              });
              Navigator.pop(context);
            },
            onClearFilter: () {
              setState(() {
                _vehicleNumberFilter = null;
                _locationFilter = null;
                _statusFilter = null;
                _filteredVehicles = _vehicles;
              });
              Navigator.pop(context);
            },
          ),
    );
  }

  void _applyFilters() {
    List<Vehicle> filtered = _vehicles;

    if (_vehicleNumberFilter?.isNotEmpty ?? false) {
      filtered =
          filtered
              .where(
                (v) => v.vehicleNumber.toLowerCase().contains(
                  _vehicleNumberFilter!.toLowerCase(),
                ),
              )
              .toList();
    }

    if (_locationFilter?.isNotEmpty ?? false) {
      filtered =
          filtered
              .where(
                (v) => v.location.toLowerCase().contains(
                  _locationFilter!.toLowerCase(),
                ),
              )
              .toList();
    }

    if (_statusFilter?.isNotEmpty ?? false) {
      filtered = filtered.where((v) => v.status == _statusFilter).toList();
    }

    setState(() {
      _filteredVehicles = filtered;
    });
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'online':
        return Colors.green;
      case 'offline':
        return Colors.red;
      case 'maintenance':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  void _toggleStatusPanel(Vehicle? vehicle) {
    setState(() {
      if (_selectedVehicle == vehicle && _showStatusPanel) {
        _showStatusPanel = false;
        _selectedVehicle = null;
      } else {
        _showStatusPanel = true;
        _selectedVehicle = vehicle;
      }
    });
  }

  void _toggleExpandedDevicesList() {
    setState(() {
      _expandedDevicesList = !_expandedDevicesList;
    });
  }

  Widget _buildMapScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFF0558A7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0558A7),
        title: const Text(
          'Map',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadVehicles,
          ),
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.white),
            onPressed: _showFilterBottomSheet,
          ),
          IconButton(
            icon: const Icon(Icons.remove_red_eye, color: Colors.white),
            onPressed: () {
              setState(() {
                _showVehicleNumbers = !_showVehicleNumbers;
              });
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(height: 1.0, color: Colors.white),
        ),
      ),
      body:
          _isLoading
              ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
              : Stack(
                children: [
                  // Main content with map and vehicle list
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Stack(
                            children: [
                              // Map placeholder
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                ),
                                child: Stack(
                                  children: [
                                    const Center(
                                      child: Text(
                                        'Map Placeholder\n(Real map integration)',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                    // Zoom controls
                                    Positioned(
                                      top: 20,
                                      right: 20,
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  blurRadius: 4,
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              children: [
                                                IconButton(
                                                  constraints:
                                                      const BoxConstraints(
                                                        minWidth: 36,
                                                        minHeight: 36,
                                                      ),
                                                  padding: EdgeInsets.zero,
                                                  icon: const Icon(Icons.add),
                                                  onPressed: () {},
                                                ),
                                                const Divider(
                                                  height: 1,
                                                  thickness: 1,
                                                ),
                                                IconButton(
                                                  constraints:
                                                      const BoxConstraints(
                                                        minWidth: 36,
                                                        minHeight: 36,
                                                      ),
                                                  padding: EdgeInsets.zero,
                                                  icon: const Icon(
                                                    Icons.remove,
                                                  ),
                                                  onPressed: () {},
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Vehicle markers on map
                                    ..._filteredVehicles.asMap().entries.map((
                                      entry,
                                    ) {
                                      int index = entry.key;
                                      Vehicle vehicle = entry.value;

                                      final double top =
                                          80.0 + (index * 60 % 300);
                                      final double left =
                                          40.0 + (index * 90 % 300);

                                      return Positioned(
                                        top: top,
                                        left: left,
                                        child: GestureDetector(
                                          onTap:
                                              () => _toggleStatusPanel(vehicle),
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: _getStatusColor(
                                                    vehicle.status,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                padding: const EdgeInsets.all(
                                                  4,
                                                ),
                                                child: const Icon(
                                                  Icons.directions_car,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                              if (_showVehicleNumbers)
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                    top: 4,
                                                  ),
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 2,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Colors.black26,
                                                        blurRadius: 3,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Text(
                                                    vehicle.vehicleNumber,
                                                    style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),

                              // Bottom devices panel
                              if (_showDevicesList)
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Column(
                                    children: [
                                      Container(
                                        color: const Color(0xFF0558A7),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'My Devices',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: Icon(
                                                    _expandedDevicesList
                                                        ? Icons.fullscreen_exit
                                                        : Icons.fullscreen,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                  constraints:
                                                      const BoxConstraints(),
                                                  padding: EdgeInsets.zero,
                                                  onPressed:
                                                      _toggleExpandedDevicesList,
                                                ),
                                                
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height:
                                            _expandedDevicesList
                                                ? MediaQuery.of(
                                                      context,
                                                    ).size.height *
                                                    0.7
                                                : 120,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: ListView(
                                          padding: EdgeInsets.zero,
                                          children: [
                                            _buildDeviceListHeader(),
                                            ..._filteredVehicles.map(
                                              (vehicle) =>
                                                  _buildDeviceListItem(vehicle),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Status details panel (full map view height)
                  if (_showStatusPanel && _selectedVehicle != null)
                    Positioned(
                      top: 0,
                      right: 0,
                      bottom:
                          _showDevicesList
                              ? (_expandedDevicesList
                                  ? MediaQuery.of(context).size.height * 0.7
                                  : 120)
                              : 0, // Account for the devices list height
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: _buildStatusDetailsPanel(_selectedVehicle!),
                    ),
                ],
              ),
    );
  }

  Widget _buildDeviceListHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'Name',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Status',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Speed',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Last Update',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceListItem(Vehicle vehicle) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: vehicle == _selectedVehicle ? const Color(0xFFE8F6E8) : null,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: GestureDetector(
        onTap: () => _toggleStatusPanel(vehicle),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                vehicle.vehicleNumber,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor(vehicle.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  vehicle.status == 'active' ? 'Online' : vehicle.status,
                  style: TextStyle(
                    color: _getStatusColor(vehicle.status),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '${(vehicle.hashCode % 60 + 5).toString()} km/h',
                style: const TextStyle(fontSize: 12),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '${(vehicle.hashCode % 5).toString()} minutes',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusDetailsPanel(Vehicle vehicle) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Container(
            color: const Color(0xFF0558A7),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Status Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  onPressed: () => _toggleStatusPanel(null),
                ),
              ],
            ),
          ),
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                scrollbarTheme: ScrollbarThemeData(
                  thickness: MaterialStateProperty.all(6.0),
                  thumbColor: MaterialStateProperty.all(Colors.grey.shade400),
                  radius: const Radius.circular(10.0),
                  minThumbLength: 80.0,
                  trackVisibility: MaterialStateProperty.all(true),
                  trackColor: MaterialStateProperty.all(Colors.grey.shade200),
                ),
              ),
              child: Scrollbar(
                controller: _statusDetailsScrollController,
                thickness: 6.0,
                radius: const Radius.circular(10.0),
                thumbVisibility: true,
                trackVisibility: true,
                child: ListView(
                  controller: _statusDetailsScrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: [
                    _buildStatusDetailItem(
                      'Parameter',
                      'Value',
                      isHeader: true,
                    ),
                    _buildStatusDetailItem('Valid', 'Yes'),
                    _buildStatusDetailItem('Trip Odometer', '0.44 km'),
                    _buildStatusDetailItem('Total Distance', '16178.14 km'),
                    _buildStatusDetailItem(
                      'Time',
                      '${DateTime.now().hour}:${DateTime.now().minute} pm',
                    ),
                    _buildStatusDetailItem(
                      'Speed',
                      '6.0 km/h',
                      highlight: true,
                    ),
                    _buildStatusDetailItem('Satellites', '19'),
                    _buildStatusDetailItem('RSSI', '4'),
                    _buildStatusDetailItem('Protocol', 'teltonika'),
                    _buildStatusDetailItem('Priority', '0'),
                    _buildStatusDetailItem('Power', '14.04 V'),
                    _buildStatusDetailItem('Out1', 'No'),
                    _buildStatusDetailItem('Odometer', '120561.31 km'),
                    _buildStatusDetailItem('Motion', 'Yes'),
                    _buildStatusDetailItem('Longitude', '74.098453°'),
                    _buildStatusDetailItem('Latitude', '31.677668°'),
                    _buildStatusDetailItem('Io69', '1'),
                    _buildStatusDetailItem('Io200', '0'),
                    _buildStatusDetailItem('Io113', '84'),
                    _buildStatusDetailItem('Ignition', 'Yes'),
                    _buildStatusDetailItem('Engine', 'On'),
                    _buildStatusDetailItem('Fuel Level', '68%'),
                    _buildStatusDetailItem('Battery', 'Good'),
                    _buildStatusDetailItem('Last Service', '245 km ago'),
                    _buildStatusDetailItem('Next Service Due', 'In 755 km'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDetailItem(
    String parameter,
    String value, {
    bool isHeader = false,
    bool highlight = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: highlight ? const Color(0xFFFFF9D9) : null,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              parameter,
              style: TextStyle(
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              value,
              style: TextStyle(
                fontWeight:
                    isHeader || highlight ? FontWeight.bold : FontWeight.normal,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> get _screens => [
    _buildMapScreen(),
    const AlertsScreen(),
    const DashboardScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF0558A7),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.space_dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
