import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pinpoint/feat_home/presentation/viewmodels/home_viewmodel.dart';
import 'package:pinpoint/feat_home/presentation/widget/bottom_sheet_form.dart';
import 'package:pinpoint/feat_home/presentation/widget/empty_widget.dart';
import '../widget/header_widget.dart';
import '../widget/item_address_widget.dart';
import '../widget/maps_widget.dart';
import '../widget/search_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pinpoint/feat_home/domain/model/address_entity.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 48),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: HeaderWidget(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    // Map Widget
                    MapWidget(
                      markers: viewModel.addresses,
                      onMapCreated: (controller) {
                        viewModel.setMapController(controller);
                      },
                      onCameraMove: (position) =>
                          viewModel.selectLocation(position.target),
                      onMapTapped: (position) =>
                          viewModel.selectLocation(position),
                    ),
                    const SizedBox(height: 16),
                    // Search Widget
                    SearchWidget(
                      hintText: 'Cari Lokasi',
                      controller: searchController,
                      onChanged: (value) {
                        viewModel.search(value); // Updates the search query
                      },
                    ),
                    const SizedBox(height: 16),
                    // Conditional Loading or Address List
                    if (viewModel.isLoading)
                      const Center(child: CircularProgressIndicator()),
                    if (!viewModel.isLoading &&
                        viewModel.filteredAddresses.isEmpty)
                      const EmptyWidget(),
                    if (!viewModel.isLoading &&
                        viewModel.filteredAddresses.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: viewModel.filteredAddresses.length,
                        itemBuilder: (context, index) {
                          final address = viewModel.filteredAddresses[index];
                          return AddressItemWidget(
                            title: address.name,
                            address: address.address,
                            latitude: address.latitude,
                            longitude: address.longitude,
                            onEdit: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => BottomSheetForm(
                                  initialName: address.name,
                                  initialAddress: address.address,
                                  initialLatitude: address.latitude,
                                  initialLongitude: address.longitude,
                                  onSubmit:
                                      (name, updatedAddress, latitude, longitude) {
                                    viewModel.updateAddress(index,
                                        AddressEntity(
                                          name: name,
                                          address: updatedAddress,
                                          latitude: latitude,
                                          longitude: longitude,
                                        ));
                                  },
                                  onDelete: () {
                                    viewModel.deleteAddress(index);
                                  },
                                ),
                              );
                            },
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
      // Floating Action Button for Adding Address
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => BottomSheetForm(
              onSubmit: (name, address, latitude, longitude) {
                viewModel.addAddress(AddressEntity(
                  name: name,
                  address: address,
                  latitude: latitude,
                  longitude: longitude,
                ));
              },
            ),
          );
        },
        backgroundColor: Colors.blue[700],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
