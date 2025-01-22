import 'package:flutter/material.dart';
import 'package:pinpoint/feat_home/domain/usecases/add_address_usecase.dart';
import 'package:pinpoint/feat_home/domain/usecases/delete_address_usecase.dart';
import 'package:pinpoint/feat_home/domain/usecases/get_addresses_usecase.dart';
import 'package:pinpoint/feat_home/domain/usecases/update_address_usecase.dart';
import 'package:pinpoint/feat_home/domain/model/address_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeViewModel extends ChangeNotifier {
  final AddAddressUseCase addAddressUseCase;
  final DeleteAddressUseCase deleteAddressUseCase;
  final GetAddressesUseCase getAddressesUseCase;
  final UpdateAddressUseCase updateAddressUseCase;

  List<AddressEntity> _addresses = [];
  List<AddressEntity> get addresses => _addresses;

  List<AddressEntity> _filteredAddresses = [];
  List<AddressEntity> get filteredAddresses => _filteredAddresses;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  LatLng? _selectedLocation;
  LatLng? get selectedLocation => _selectedLocation;

  GoogleMapController? _mapController;
  GoogleMapController? get mapController => _mapController;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int? _selectedIndex;
  int? get selectedIndex => _selectedIndex;

  HomeViewModel({
    required this.addAddressUseCase,
    required this.deleteAddressUseCase,
    required this.getAddressesUseCase,
    required this.updateAddressUseCase,
  }) {
    loadAddresses(); // Load addresses on initialization
  }

  /// Initializes Google Map Controller
  void setMapController(GoogleMapController controller) {
    _mapController = controller;
    centerMap(); // Center map when the controller is set
  }

  /// Centers the map dynamically based on available data
  void centerMap() {
    if (_mapController == null) return;

    if (_selectedLocation != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLng(_selectedLocation!),
      );
    } else if (_addresses.isNotEmpty) {
      LatLngBounds bounds = _calculateLatLngBounds(_addresses);
      _mapController!.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 100),
      );
    }
  }

  /// Calculates LatLngBounds based on the list of addresses
  LatLngBounds _calculateLatLngBounds(List<AddressEntity> addresses) {
    double minLat = double.infinity;
    double maxLat = double.negativeInfinity;
    double minLng = double.infinity;
    double maxLng = double.negativeInfinity;

    for (var address in addresses) {
      double lat = double.parse(address.latitude);
      double lng = double.parse(address.longitude);

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

  /// Loads addresses from the database and updates the filtered list
  Future<void> loadAddresses() async {
    _setLoading(true);
    try {
      final result = await getAddressesUseCase.execute();
      _addresses = result;
      _updateFilteredAddresses(); // Refresh the filtered list
    } catch (e) {
      print('Error loading addresses: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Adds a new address to the database
  Future<void> addAddress(AddressEntity address) async {
    _setLoading(true);
    try {
      await addAddressUseCase.execute(address);
      await loadAddresses();
    } finally {
      _setLoading(false);
    }
  }

  /// Deletes an address by index
  Future<void> deleteAddress(int index) async {
    if (index < 0 || index >= _addresses.length) {
      print('Invalid index for deletion: $index');
      return;
    }

    _setLoading(true);
    try {
      await deleteAddressUseCase.execute(index);
      await loadAddresses();
    } catch (e) {
      print('Error deleting address: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Updates an existing address in the database
  Future<void> updateAddress(int index, AddressEntity updatedAddress) async {
    if (index < 0 || index >= _addresses.length) {
      print('Invalid index for update: $index');
      return;
    }

    _setLoading(true);
    try {
      await updateAddressUseCase.execute(index, updatedAddress);
      await loadAddresses();
    } catch (e) {
      print('Error updating address: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Sets the selected location on the map
  void selectLocation(LatLng location) {
    _selectedLocation = location;
    notifyListeners();
  }

  /// Handles the search query and updates the filtered list
  void search(String query) {
    _searchQuery = query.toLowerCase();
    _updateFilteredAddresses(); // Dynamically update filtered list
  }

  /// Updates the filtered list based on the search query
  void _updateFilteredAddresses() {
    if (_searchQuery.isEmpty) {
      _filteredAddresses = _addresses;
    } else {
      _filteredAddresses = _addresses.where((address) {
        return address.name.toLowerCase().contains(_searchQuery) ||
            address.address.toLowerCase().contains(_searchQuery);
      }).toList();
    }
    notifyListeners();
  }

  /// Sets the loading state and notifies listeners
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
