import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../widget/header_widget.dart';
import '../widget/maps_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final LatLng center = const LatLng(45.521563, -122.677433);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32), // Spacer at the top
            const HeaderWidget(),
            const SizedBox(height: 16),
            MapWidget(
              center: center,
              onMapCreated: (controller) {
              },
              onCameraMove: (position) {
              },
              onMapTapped: (position) {
              },
            ),
          ],
        ),
      ),
    );
  }
}