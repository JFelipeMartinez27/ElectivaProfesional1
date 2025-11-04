import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parqueadero_2025_g2/auth/session_manager.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Text(
              'Menú',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          //!INICIO
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              context.go('/');
              Navigator.pop(context);
            },
          ),
          //!COMIDA
          ListTile(
            leading: const Icon(Icons.restaurant_menu),
            title: const Text('Comida'),
            onTap: () {
              context.push('/comida');
              Navigator.pop(context);
            },
          ),
          //!PASO DE PARAMETROS
          ListTile(
            leading: const Icon(Icons.input),
            title: const Text('Paso de Parámetros'),
            onTap: () {
              context.go('/paso_parametros');
              Navigator.pop(context);
            },
          ),
          //!CICLO DE VIDA
          ListTile(
            leading: const Icon(Icons.loop),
            title: const Text('Ciclo de Vida'),
            onTap: () {
              context.go('/ciclo_vida');
              Navigator.pop(context);
            },
          ),
          //!GRID + TABS
          ListTile(
            leading: const Icon(Icons.grid_on),
            title: const Text("Grid + Tabs"),
            onTap: () {
              context.go('/grid_tab');
              Navigator.pop(context);
            },
          ),
          //!FUTURE
          ListTile(
            leading: const Icon(Icons.flag_circle),
            title: const Text('Future'),
            onTap: () {
              context.go('/future');
              Navigator.pop(context);
            },
          ),
          //!TIMER
          ListTile(
            leading: const Icon(Icons.timer),
            title: const Text('Cronómetro'),
            onTap: () {
              context.go('/cronometro');
              Navigator.pop(context);
            },
          ),
          //!ISOLATE
          ListTile(
            leading: const Icon(Icons.memory),
            title: const Text('Isolate'),
            onTap: () {
              context.go('/isolate');
              Navigator.pop(context);
            },
          ),
          
          //! ========== RAZAS DE PERROS ==========
          const Divider(),
          ListTile(
            leading: const Icon(Icons.pets, color: Colors.green),
            title: const Text(
              'Razas de Perros',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('API HTTP - Dog CEO'),
            onTap: () {
              Navigator.pop(context);
              context.go('/dog_breeds');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.verified_user),
            title: const Text('Evidencia de sesión'),
            onTap: () {
              Navigator.pop(context);
              context.go('/evidence');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Cerrar sesión'),
            onTap: () async {
              await SessionManager.clearAll();
              if (context.mounted) {
                Navigator.pop(context);
                context.go('/login');
              }
            },
          ),
        ],
      ),
    );
  }
}