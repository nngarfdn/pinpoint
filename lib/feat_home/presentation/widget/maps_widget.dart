import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {
  final LatLng center;
  final Function(GoogleMapController) onMapCreated;
  final Function(CameraPosition) onCameraMove;
  final Function(LatLng) onMapTapped;

  const MapWidget({
    super.key,
    required this.center,
    required this.onMapCreated,
    required this.onCameraMove,
    required this.onMapTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        height: 250, // Set height of the map
        width: double.infinity, // Map takes the full width of the card
        child: GoogleMap(
          onMapCreated: (controller) => onMapCreated(controller),
          initialCameraPosition: CameraPosition(
            target: center, // Center location for the map
            zoom: 10,
          ),
          onCameraMove: (position) => onCameraMove(position),
          onTap: (position) => onMapTapped(position),
        ),
      ),
    );
  }
}