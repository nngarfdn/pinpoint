import 'package:hive/hive.dart';

part 'address.g.dart'; // Required for the generated adapter

@HiveType(typeId: 0)
class AddressModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String address;

  @HiveField(2)
  final String latitude;

  @HiveField(3)
  final String longitude;

  AddressModel({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  // Convert to Map (for storage)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // Create from Map (for retrieval)
  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      name: map['name'] as String,
      address: map['address'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
    );
  }
}