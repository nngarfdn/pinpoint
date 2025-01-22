import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../feat_full_screen_map/full_screen_map_page.dart';
import '../../../feat_home/domain/model/address_entity.dart';

class MapWidget extends StatelessWidget {
  final Function(GoogleMapController) onMapCreated;
  final Function(CameraPosition) onCameraMove;
  final Function(LatLng) onMapTapped;
  final List<AddressEntity> markers; // Add a list of AddressEntity for markers

  const MapWidget({
    super.key,
    required this.onMapCreated,
    required this.onCameraMove,
    required this.onMapTapped,
    required this.markers, // Required parameter for markers
  });

  LatLng _calculateCenter() {
    if (markers.isEmpty) {
      // Default center if no markers are available
      return const LatLng(-7.967917829848784, 110.21875865100343);
    }

    // Calculate the average latitude and longitude of all markers
    final double averageLatitude = markers
        .map((marker) => double.parse(marker.latitude))
        .reduce((a, b) => a + b) /
        markers.length;

    final double averageLongitude = markers
        .map((marker) => double.parse(marker.longitude))
        .reduce((a, b) => a + b) /
        markers.length;

    return LatLng(averageLatitude, averageLongitude);
  }

  @override
  Widget build(BuildContext context) {
    final LatLng center = _calculateCenter(); // Dynamically calculate the center

    return Card(
      elevation: 6,
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
              markers: markers
                  .map((address) => Marker(
                markerId: MarkerId(address.name),
                position: LatLng(
                  double.parse(address.latitude),
                  double.parse(address.longitude),
                ),
                infoWindow: InfoWindow(
                  title: address.name,
                  snippet: address.address,
                ),
              ))
                  .toSet(),
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
                      onMapCreated: onMapCreated,
                      onCameraMove: onCameraMove,
                      onMapTapped: onMapTapped,
                      markers: markers, // Pass the markers to the fullscreen map
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
                      offset: const Offset(0, 2), // Shadow position
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