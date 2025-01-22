import '../repositories/address_repository.dart';

class DeleteAddressUseCase {
  final AddressRepository repository;

  DeleteAddressUseCase({required this.repository});

  Future<void> execute(int index) async {
    if (index < 0) {
      throw Exception('Invalid index');
    }
    await repository.deleteAddress(index);
  }
}