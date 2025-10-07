import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
              color: Theme.of(
                context,
              ).colorScheme.primary, // Usa el color primario del tema
            ),
            child: const Text(
              'Menú',
              style: TextStyle(
                color: Colors
                    .white, // Texto blanco para contrastar con el color primario
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
              Navigator.pop(context); // Cierra el drawer
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
            },
          ),
          //!CICLO DE VIDA
          ListTile(
            leading: const Icon(Icons.loop),
            title: const Text('Ciclo de Vida'),
            onTap: () {
              context.go('/ciclo_vida');
            },
          ),
          //!GRID + TABS
          ListTile(
            leading: const Icon(Icons.grid_on),
            title: const Text("Grid + Tabs"),
            onTap: () {
              context.go('/grid_tab');
              },
          ),
          //!FUTURE
          ListTile(
            leading: const Icon(Icons.flag_circle),
            title: const Text('Future'),
            onTap: () {
              context.go('/future');
            },
          ),
          //!TIMER
          ListTile(
            leading: const Icon(Icons.timer),
            title: const Text('Cronómetro'),
            onTap: () {
              context.go('/cronometro');
            },
          ),
          //!ISOLATE
          ListTile(
            leading: const Icon(Icons.memory),
            title: const Text('Isolate'),
            onTap: () {
              context.go('/isolate');
            },
          ),
        ],
      ),
    );
  }
}


