import '../../domain/repositories/address_repository.dart';
import '../../domain/model/address_entity.dart';
import '../datasources/hive_local_datasource.dart';
import '../models/address.dart';

class AddressRepositoryImpl implements AddressRepository {
  final HiveLocalDatasource datasource;

  AddressRepositoryImpl({required this.datasource});

  @override
  void getName() {
    datasource.getName();
  }

  @override
  Future<void> addAddress(AddressEntity address) async {
    // Map AddressEntity to AddressModel
    final addressModel = AddressModel(
      name: address.name,
      address: address.address,
      latitude: address.latitude,
      longitude: address.longitude,
    );
    await datasource.saveAddress(addressModel);
  }

  @override
  List<AddressEntity> getAddresses() {
    // Get AddressModel from datasource and map to AddressEntity
    final addressModels = datasource.getAddresses();
    return addressModels.map((model) {
      return AddressEntity(
        name: model.name,
        address: model.address,
        latitude: model.latitude,
        longitude: model.longitude,
      );
    }).toList();
  }

  @override
  Future<void> deleteAddress(int index) async {
    await datasource.deleteAddress(index);
  }

  @override
  Future<void> clearAllAddresses() async {
    await datasource.clearAddresses();
  }
}