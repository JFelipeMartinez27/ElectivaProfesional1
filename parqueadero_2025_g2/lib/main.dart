import 'package:flutter/material.dart';
import 'package:parqueadero_2025_g2/routes/app_router.dart';
import 'package:parqueadero_2025_g2/themes/app_themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      title: 'TALLER 3',
      routerConfig: appRouter,
    );
  }
}
