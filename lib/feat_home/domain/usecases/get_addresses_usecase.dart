import '../model/address_entity.dart';
import '../repositories/address_repository.dart';

class GetAddressesUseCase {
  final AddressRepository repository;

  GetAddressesUseCase({required this.repository});

  List<AddressEntity> execute() {
    return repository.getAddresses();
  }
}