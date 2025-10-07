import 'package:go_router/go_router.dart';

import 'package:parqueadero_2025_g2/paso_parametros_ciclo_vida/views/ciclo_vida/ciclo_vida_screen.dart';
import 'package:parqueadero_2025_g2/paso_parametros_ciclo_vida/views/cronometro/timer_screen.dart';
import 'package:parqueadero_2025_g2/paso_parametros_ciclo_vida/views/isolate/isolate_screen.dart';
import 'package:parqueadero_2025_g2/paso_parametros_ciclo_vida/views/paso_parametros/detalle_screen.dart';
import 'package:parqueadero_2025_g2/paso_parametros_ciclo_vida/views/paso_parametros/paso_parametros_screen.dart';
import 'package:parqueadero_2025_g2/paso_parametros_ciclo_vida/views/tabbar_widget/vehiculos_screen.dart';
import 'package:parqueadero_2025_g2/paso_parametros_ciclo_vida/views/future/future_screen.dart';
import 'package:parqueadero_2025_g2/paso_parametros_ciclo_vida/views/grid_tab/grid_tab_screen.dart';

import '../views/home/home_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(), // Usa HomeView
    ),
    // Rutas para el paso de parámetros
    GoRoute(
      path: '/paso_parametros',
      name: 'paso_parametros',
      builder: (context, state) => const PasoParametrosScreen(),
    ),

    // !Ruta para el detalle con parámetros
    GoRoute(
      path:
          '/detalle/:parametro/:metodo', //la ruta recibe dos parametros los " : " indican que son parametros
      builder: (context, state) {
        //*se capturan los parametros recibidos
        // declarando las variables parametro y metodo
        // es final porque no se van a modificar
        final parametro = state.pathParameters['parametro']!;
        final metodo = state.pathParameters['metodo']!;
        return DetalleScreen(parametro: parametro, metodoNavegacion: metodo);
      },
    ),
    //!Ruta para el ciclo de vida
    GoRoute(
      path: '/ciclo_vida',
      builder: (context, state) => const CicloVidaScreen(),
    ),
    //!Ruta para el Grid + Tabs
    GoRoute(
      path: '/grid_tab',
      builder: (context, state) => const GridTabScreen(),
    ),
    //!Ruta para el TabBar de Vehículos
    GoRoute(
      path: '/comida',
      name: 'comida',
      builder: (context, state) => const ComidaScreen(),
    ),
    //!Ruta para el Future
    GoRoute(
      path: '/future',
      name: 'future',
      builder: (context, state) => const FutureView(),
    ),
    //!Ruta para el Cronómetro
    GoRoute(
      path: '/cronometro',
      name: 'cronometro',
      builder: (context, state) => const TimerScreen(),
    ),
    // !Ruta para el Isolate
    GoRoute(
      path: '/isolate',
      name: 'isolate',
      builder: (context, state) => const IsolateView(),
    ),
  ],
);