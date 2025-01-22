import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pinpoint/feat_home/data/datasources/hive_local_datasource.dart';
import 'package:pinpoint/feat_home/data/repositories/address_repository_impl.dart';
import 'package:pinpoint/feat_home/domain/repositories/address_repository.dart';
import 'package:pinpoint/feat_home/domain/usecases/add_address_usecase.dart';
import 'package:pinpoint/feat_home/domain/usecases/delete_address_usecase.dart';
import 'package:pinpoint/feat_home/domain/usecases/get_addresses_usecase.dart';
import 'package:pinpoint/feat_home/domain/usecases/update_address_usecase.dart';
import 'package:pinpoint/feat_home/presentation/viewmodels/home_viewmodel.dart';

final getIt = GetIt.instance;

Future<void> setupDependenciesHome() async {
  // Hive Initialization
  await Hive.initFlutter();

  // Open a Hive Box
  final box = await Hive.openBox('appBox');

  // Register Hive Box
  getIt.registerSingleton<Box>(box);

  // Register Datasource
  getIt.registerLazySingleton<HiveLocalDatasource>(() => HiveLocalDatasource(getIt<Box>()));

  // Register Repository
  getIt.registerLazySingleton<AddressRepository>(
        () => AddressRepositoryImpl(datasource: getIt<HiveLocalDatasource>()),
  );

  // Register Use Cases
  getIt.registerLazySingleton<AddAddressUseCase>(
        () => AddAddressUseCase(repository: getIt<AddressRepository>()),
  );
  getIt.registerLazySingleton<DeleteAddressUseCase>(
        () => DeleteAddressUseCase(repository: getIt<AddressRepository>()),
  );
  getIt.registerLazySingleton<GetAddressesUseCase>(
        () => GetAddressesUseCase(repository: getIt<AddressRepository>()),
  );
  getIt.registerLazySingleton<UpdateAddressUseCase>(
        () => UpdateAddressUseCase(repository: getIt<AddressRepository>()),
  );

  // Register ViewModel
  getIt.registerFactory<HomeViewModel>(
        () => HomeViewModel(
      addAddressUseCase: getIt<AddAddressUseCase>(),
      deleteAddressUseCase: getIt<DeleteAddressUseCase>(),
      getAddressesUseCase: getIt<GetAddressesUseCase>(),
      updateAddressUseCase: getIt<UpdateAddressUseCase>(),
    ),
  );
}