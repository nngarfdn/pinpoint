import 'package:hive/hive.dart';
import '../models/address.dart';
import 'local_storage_keys.dart';

class HiveLocalDatasource {
  final Box _box;

  HiveLocalDatasource(this._box);

  void getName() {
    print('halo: HiveLocalDatasource');
  }

  // Save an address
  Future<void> saveAddress(AddressModel address) async {
    await _box.add(address.toMap());
  }

  // Get all saved addresses
  List<AddressModel> getAddresses() {
    return _box.values.map((data) => AddressModel.fromMap(Map<String, dynamic>.from(data))).toList();
  }

  // Delete an address by index
  Future<void> deleteAddress(int index) async {
    await _box.deleteAt(index);
  }

  // Clear all addresses
  Future<void> clearAddresses() async {
    await _box.clear();
  }
}