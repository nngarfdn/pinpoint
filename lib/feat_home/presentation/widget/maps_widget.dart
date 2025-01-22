import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../feat_full_screen_map/full_screen_map_page.dart';
import '../../../feat_home/domain/model/address_entity.dart';

class MapWidget extends StatefulWidget {
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

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  MapType _currentMapType = MapType.normal; // Default map type

  LatLng _calculateCenter() {
    if (widget.markers.isEmpty) {
      return const LatLng(-7.967917829848784, 110.21875865100343);
    }

    final double averageLatitude = widget.markers
        .map((marker) => double.parse(marker.latitude))
        .reduce((a, b) => a + b) /
        widget.markers.length;

    final double averageLongitude = widget.markers
        .map((marker) => double.parse(marker.longitude))
        .reduce((a, b) => a + b) /
        widget.markers.length;

    return LatLng(averageLatitude, averageLongitude);
  }

  void _changeMapType(MapType mapType) {
    setState(() {
      _currentMapType = mapType; // Update the map type
    });
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
              mapType: _currentMapType, // Set the current map type
              onMapCreated: (controller) {
                widget.onMapCreated(controller);
              },
              initialCameraPosition: CameraPosition(
                target: center,
                zoom: 10,
              ),
              onCameraMove: widget.onCameraMove,
              onTap: widget.onMapTapped,
              markers: widget.markers
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
                      onMapCreated: widget.onMapCreated,
                      onCameraMove: widget.onCameraMove,
                      onMapTapped: widget.onMapTapped,
                      markers: widget.markers,
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
          // Map Type Selector (Single Icon with Dropdown)
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
