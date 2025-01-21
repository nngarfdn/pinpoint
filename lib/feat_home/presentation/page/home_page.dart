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
                    // Address List
                    const SizedBox(height: 16), // If you added a SizedBox previously, ensure it is set to 0
                    ListView.builder(
                      shrinkWrap: true, // Ensures the list takes only the necessary space
                      physics: const NeverScrollableScrollPhysics(), // Disables scrolling for the list
                      padding: EdgeInsets.zero, // Removes any default padding
                      itemCount: 10, // Number of items in the list
                      itemBuilder: (context, index) {
                        final screenHeight = MediaQuery.of(context).size.height;

                        return Container(
                          margin: EdgeInsets.only(bottom: screenHeight * 0.01), // Dynamically adjust vertical spacing
                          child: AddressItemWidget(
                            title: 'Item $index',
                            address: 'Address for Item $index',
                            latitude: '7.32432$index',
                            longitude: '8.89789$index',
                            onEdit: () {
                              print('Edit button pressed for Item $index');
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FAB Pressed! Open Add Address Form');
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