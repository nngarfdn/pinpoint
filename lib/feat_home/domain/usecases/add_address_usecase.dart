import '../model/address_entity.dart';
import '../repositories/address_repository.dart';

class AddAddressUseCase {
  final AddressRepository repository;

  AddAddressUseCase({required this.repository});

  Future<void> execute(AddressEntity address) async {
    if (address.name.isEmpty || address.address.isEmpty) {
      throw Exception('Name and address cannot be empty');
    }
    await repository.addAddress(address);
  }

  void getName() {
    repository.getName();
  }

}