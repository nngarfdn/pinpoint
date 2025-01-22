import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pinpoint/feat_home/domain/model/address_entity.dart';

class FullScreenMap extends StatefulWidget {
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

  @override
  _FullScreenMapState createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  MapType _currentMapType = MapType.normal; // Default map type

  LatLngBounds _calculateBounds() {
    if (widget.markers.isEmpty) {
      // Default bounds if no markers are available
      return LatLngBounds(
        southwest: const LatLng(-7.967917829848784, 110.21875865100343),
        northeast: const LatLng(-7.967917829848784, 110.21875865100343),
      );
    }

    double minLat = double.infinity;
    double maxLat = double.negativeInfinity;
    double minLng = double.infinity;
    double maxLng = double.negativeInfinity;

    for (var marker in widget.markers) {
      final lat = double.parse(marker.latitude);
      final lng = double.parse(marker.longitude);

      if (lat < minLat) minLat = lat;
      if (lat > maxLat) maxLat = lat;
      if (lng < minLng) minLng = lng;
      if (lng > maxLng) maxLng = lng;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  void _centerMapOnBounds(GoogleMapController controller) {
    final bounds = _calculateBounds();
    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  void _changeMapType(MapType mapType) {
    setState(() {
      _currentMapType = mapType; // Update the map type
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fullscreen Map',
          style: TextStyle(color: Colors.white), // Set title color to white
        ),
        backgroundColor: Colors.blue[700],
        iconTheme: const IconThemeData(color: Colors.white), // Set icon color to white
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back button
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            mapType: _currentMapType, // Set the current map type
            onMapCreated: (controller) {
              widget.onMapCreated(controller);
              Future.delayed(const Duration(milliseconds: 500), () {
                _centerMapOnBounds(controller); // Center map dynamically
              });
            },
            initialCameraPosition: CameraPosition(
              target: const LatLng(-7.967917829848784, 110.21875865100343), // Default center
              zoom: 10,
            ),
            onCameraMove: (position) => widget.onCameraMove(position),
            onTap: (position) => widget.onMapTapped(position),
            markers: widget.markers
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
          // Map Type Selector (Top Left)
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // White background
                shape: BoxShape.circle, // Circular shape
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26, // Shadow color
                    blurRadius: 6, // Shadow blur radius
                    offset: const Offset(0, 2), // Shadow offset
                  ),
                ],
              ),
              padding: const EdgeInsets.all(0), // Padding inside the circle
              child: PopupMenuButton<MapType>(
                icon: const Icon(
                  Icons.layers, // Icon for map type selector
                  color: Colors.blue, // Icon color
                  size: 28, // Icon size
                ),
                onSelected: (MapType selectedMapType) {
                  _changeMapType(selectedMapType); // Change the map type
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: MapType.normal,
                    child: Text('Normal'),
                  ),
                  const PopupMenuItem(
                    value: MapType.satellite,
                    child: Text('Satellite'),
                  ),
                  const PopupMenuItem(
                    value: MapType.terrain,
                    child: Text('Terrain'),
                  ),
                  const PopupMenuItem(
                    value: MapType.hybrid,
                    child: Text('Hybrid'),
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
