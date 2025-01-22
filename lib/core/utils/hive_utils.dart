// import 'package:hive/hive.dart';
// import 'constants.dart';
//
// class HiveUtils {
//   // Initialize Hive
//   static Future<void> initHive() async {
//     try {
//       await Hive.initFlutter();
//       await Hive.openBox(AppConstants.hiveBoxName);
//       print('Hive initialized and box opened');
//     } catch (e) {
//       print('Error initializing Hive: $e');
//     }
//   }
//
//   // Clear Hive Box (For testing or reset purposes)
//   static Future<void> clearBox(String boxName) async {
//     final box = Hive.box(boxName);
//     await box.clear();
//     print('Hive box cleared: $boxName');
//   }
//
//   // Close Hive Box
//   static Future<void> closeHive() async {
//     await Hive.close();
//     print('Hive closed');
//   }
// }