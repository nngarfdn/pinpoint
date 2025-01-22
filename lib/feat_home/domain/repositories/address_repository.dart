import '../model/address_entity.dart';

abstract class AddressRepository {
  Future<void> addAddress(AddressEntity address);
  List<AddressEntity> getAddresses();
  Future<void> deleteAddress(int index);
  Future<void> clearAllAddresses();
  void getName();
}