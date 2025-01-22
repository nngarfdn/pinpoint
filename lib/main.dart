import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'feat_home//di/di.dart';
import 'feat_home/presentation/viewmodels/home_viewmodel.dart';
import 'feat_home/presentation/page/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup Dependency Injection
  await setupDependenciesHome();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<HomeViewModel>()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.green[700],
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          // Add other routes here if needed
        },
      ),
    );
  }
}