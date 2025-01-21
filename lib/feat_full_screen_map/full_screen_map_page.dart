import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FullScreenMap extends StatelessWidget {
  final LatLng center;
  final Function(GoogleMapController) onMapCreated;
  final Function(CameraPosition) onCameraMove;
  final Function(LatLng) onMapTapped;

  const FullScreenMap({
    super.key,
    required this.center,
    required this.onMapCreated,
    required this.onCameraMove,
    required this.onMapTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (controller) => onMapCreated(controller),
        initialCameraPosition: CameraPosition(
          target: center,
          zoom: 10,
        ),
        onCameraMove: (position) => onCameraMove(position),
        onTap: (position) => onMapTapped(position),
      ),
    );
  }
}