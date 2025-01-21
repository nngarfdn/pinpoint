import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../feat_full_screen_map/full_screen_map_page.dart';

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
      child: Stack(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: GoogleMap(
              onMapCreated: (controller) => onMapCreated(controller),
              initialCameraPosition: CameraPosition(
                target: center,
                zoom: 10,
              ),
              onCameraMove: (position) => onCameraMove(position),
              onTap: (position) => onMapTapped(position),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenMap(
                      center: center,
                      onMapCreated: onMapCreated,
                      onCameraMove: onCameraMove,
                      onMapTapped: onMapTapped,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  shape: BoxShape.circle, // Makes it circular
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26, // Shadow color
                      blurRadius: 6, // Shadow blur
                      offset: Offset(0, 2), // Shadow position
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(8), // Inner padding for icon
                child: const Icon(
                  Icons.fullscreen,
                  color: Colors.blue, // Icon color
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}