import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pinpoint/feat_home/domain/model/address_entity.dart';

class FullScreenMap extends StatelessWidget {
  final Function(GoogleMapController) onMapCreated;
  final Function(CameraPosition) onCameraMove;
  final Function(LatLng) onMapTapped;
  final List<AddressEntity> markers;

  const FullScreenMap({
    super.key,
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

  @override
  Widget build(BuildContext context) {
    final LatLng center = _calculateCenter();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fullscreen Map'),
        backgroundColor: Colors.blue[700],
      ),
      body: GoogleMap(
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
    );
  }
}