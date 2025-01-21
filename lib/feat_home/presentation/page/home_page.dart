import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../widget/header_widget.dart';
import '../widget/item_address_widget.dart';
import '../widget/maps_widget.dart';
import '../widget/search_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

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
                print('Map created successfully.');
              },
              onCameraMove: (position) {
                print('Camera moved to: ${position.target.latitude}, ${position.target.longitude}');
              },
              onMapTapped: (position) {
                print('Map tapped at: ${position.latitude}, ${position.longitude}');
              },
            ),
            const SizedBox(height: 32), // Spacer for the search bar
            SearchWidget(
              hintText: 'Cari Lokasi',
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
                print('Search Text: $_searchText'); // Debugging
              },
            ),
            const SizedBox(height: 16),
            AddressItemWidget(
              title: 'Rumah Pribadi',
              address: 'Jl Laskar Jaya no 12, Srandakan, Bantul, Yogyakarta. Indonesia',
              latitude: '7.324324',
              longitude: '8.89789547',
              onEdit: () {
                print('Edit button pressed');
              },
            ),
            const SizedBox(height: 8),
            AddressItemWidget(
              title: 'Rumah Pribadi',
              address: 'Jl Laskar Jaya no 12, Srandakan, Bantul, Yogyakarta. Indonesia',
              latitude: '7.324324',
              longitude: '8.89789547',
              onEdit: () {
                print('Edit button pressed');
              },
            ),
          ],
        ),
      ),
    );
  }
}