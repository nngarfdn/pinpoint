import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  print('cekk: Starting app...');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() {
    print("cekk: Creating MyApp state...");
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  // Logs when the map is created
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    print('cekk: Google Map has been created.');
  }

  // Logs the current camera position when it changes
  void _onCameraMove(CameraPosition position) {
    print('cekk: Camera moved to: ${position.target.latitude}, ${position.target.longitude}');
  }

  // Logs the user's interaction with the map (e.g., tapping)
  void _onMapTapped(LatLng position) {
    print('cekk: Map tapped at: ${position.latitude}, ${position.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    print("cekk: Widget build called...");
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Map inside a Card',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SizedBox(
                  height: 300, // Set height of the map
                  width: double.infinity, // Map takes the full width of the card
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center, // Center location for the map
                      zoom: 10,
                    ),
                    onCameraMove: _onCameraMove, // Logs camera movement
                    onTap: _onMapTapped, // Logs map taps
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}