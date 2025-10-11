import 'package:flutter/material.dart';
import 'package:parqueadero_2025_g2/routes/app_router.dart';
import 'package:parqueadero_2025_g2/themes/app_themes.dart';

void main() {
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
