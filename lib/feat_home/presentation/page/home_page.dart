import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pinpoint/feat_home/presentation/widget/empty_widget.dart';
import '../widget/header_widget.dart';
import '../widget/item_address_widget.dart';
import '../widget/maps_widget.dart';
import '../widget/search_widget.dart';
import '../widget/bottom_sheet_form.dart'; // Import the BottomSheetForm widget

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  // Function to show the BottomSheetForm
  void _showBottomSheetForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return BottomSheetForm(
          onSubmit: (nama, alamat, latitude, longitude) {
            // Handle submitted data from the form
            print('Nama: $nama');
            print('Alamat: $alamat');
            print('Latitude: $latitude');
            print('Longitude: $longitude');
            // TODO: Add logic to save the address to the list
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final LatLng center = const LatLng(45.521563, -122.677433);

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 48), // Reduced spacing above the header
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Reduced vertical padding
            child: HeaderWidget(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8), // Reduced spacing above the map
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
                    const SizedBox(height: 16), // Reduced spacing between map and search
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
                    const SizedBox(height: 16), // Reduced spacing before the address list
                    EmptyWidget(), // Show the EmptyWidget if there are no addresses
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBottomSheetForm(context); // Show the BottomSheetForm
        },
        backgroundColor: Colors.blue[700],
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}