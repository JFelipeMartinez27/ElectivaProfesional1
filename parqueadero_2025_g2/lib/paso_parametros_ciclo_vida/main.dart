import 'package:flutter/material.dart';
import 'package:parqueadero_2025_g2/paso_parametros_ciclo_vida/routes/app_router.dart';
import 'package:parqueadero_2025_g2/paso_parametros_ciclo_vida/themes/app_themes.dart';

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
