import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../feat_full_screen_map/full_screen_map_page.dart';
import '../../../feat_home/domain/model/address_entity.dart';

class MapWidget extends StatelessWidget {
  final GoogleMapController? mapController;
  final Function(GoogleMapController) onMapCreated;
  final Function(CameraPosition) onCameraMove;
  final Function(LatLng) onMapTapped;
  final List<AddressEntity> markers;

  const MapWidget({
    super.key,
    required this.mapController,
    required this.onMapCreated,
    required this.onCameraMove,
    required this.onMapTapped,
    required this.markers,
  });

  LatLng _calculateCenter() {
    if (markers.isEmpty) {
      return const LatLng(-7.967917829848784, 110.21875865100343);
    }

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

  void _showMarkerInfoWindows(GoogleMapController controller) {
    // Loop through each marker and show its info window
    for (var address in markers) {
      controller.showMarkerInfoWindow(MarkerId(address.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    final LatLng center = _calculateCenter();

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // Google Map
          SizedBox(
            height: 250,
            width: double.infinity,
            child: GoogleMap(
              onMapCreated: (controller) {
                onMapCreated(controller);

                // Automatically show info windows for all markers
                Future.delayed(const Duration(milliseconds: 500), () {
                  _showMarkerInfoWindows(controller);
                });
              },
              initialCameraPosition: CameraPosition(
                target: center,
                zoom: 10,
              ),
              onCameraMove: onCameraMove,
              onTap: onMapTapped,
              markers: markers
                  .map((address) => Marker(
                markerId: MarkerId(address.name),
                position: LatLng(
                  double.parse(address.latitude),
                  double.parse(address.longitude),
                ),
                infoWindow: InfoWindow(
                  title: address.name, // Marker title
                  snippet: address.address, // Marker subtitle
                ),
              ))
                  .toSet(),
            ),
          ),
          // Fullscreen Button
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
                      markers: markers,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.fullscreen,
                  color: Colors.blue,
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

