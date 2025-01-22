import '../model/address_entity.dart';
import '../repositories/address_repository.dart';

class UpdateAddressUseCase {
  final AddressRepository repository;

  UpdateAddressUseCase({required this.repository});

  Future<void> execute(int index, AddressEntity updatedAddress) async {
    if (updatedAddress.name.isEmpty || updatedAddress.address.isEmpty) {
      throw Exception('Name and address cannot be empty');
    }

    // First, delete the existing address at the specified index
    await repository.deleteAddress(index);

    // Then, add the updated address
    await repository.addAddress(updatedAddress);
  }
}