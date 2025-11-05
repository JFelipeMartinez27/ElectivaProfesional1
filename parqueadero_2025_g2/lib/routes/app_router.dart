import 'package:go_router/go_router.dart';

import 'package:parqueadero_2025_g2/views/ciclo_vida/ciclo_vida_screen.dart';
import 'package:parqueadero_2025_g2/views/cronometro/timer_screen.dart';
import 'package:parqueadero_2025_g2/views/isolate/isolate_screen.dart';
import 'package:parqueadero_2025_g2/views/paso_parametros/detalle_screen.dart';
import 'package:parqueadero_2025_g2/views/paso_parametros/paso_parametros_screen.dart';
import 'package:parqueadero_2025_g2/views/tabbar_widget/comida_screen.dart';
import 'package:parqueadero_2025_g2/views/future/future_screen.dart';
import 'package:parqueadero_2025_g2/views/grid_tab/grid_tab_screen.dart';
import 'package:parqueadero_2025_g2/views/dog_view/breed_list_screen.dart';
import 'package:parqueadero_2025_g2/views/dog_view/breed_detail_screen.dart';
import 'package:parqueadero_2025_g2/models/dog_breed.dart'; // IMPORTANTE: Agregar esta importación
import 'package:parqueadero_2025_g2/auth/auth_gate.dart';
import 'package:parqueadero_2025_g2/auth/login_screen.dart';
import 'package:parqueadero_2025_g2/auth/evidence_screen.dart';
import 'package:parqueadero_2025_g2/auth/register_screen.dart';
import 'package:parqueadero_2025_g2/universidades/universities_list_screen.dart';
import 'package:parqueadero_2025_g2/universidades/university_form_screen.dart';
import 'package:parqueadero_2025_g2/universidades/university.dart';

import '../views/home/home_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/auth',
  routes: [
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthGate(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/evidence',
      builder: (context, state) => const EvidenceScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(), // Usa HomeView
    ),
    //! Universidades
    GoRoute(
      path: '/universidades',
      name: 'universidades',
      builder: (context, state) => const UniversitiesListScreen(),
    ),
    GoRoute(
      path: '/universidades/nueva',
      name: 'universidades_nueva',
      builder: (context, state) => UniversityFormScreen(
        university: state.extra is University ? state.extra as University : null,
      ),
    ),
    // Rutas para el paso de parámetros
    GoRoute(
      path: '/paso_parametros',
      name: 'paso_parametros',
      builder: (context, state) => const PasoParametrosScreen(),
    ),
    //!Ruta para el detalle con parámetros
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
    
    //! ========== NUEVAS RUTAS PARA DOG BREEDS ==========
    //! Ruta para Dog Breeds - Listado
    GoRoute(
      path: '/dog_breeds',
      name: 'dog_breeds',
      builder: (context, state) => const BreedListScreen(),
    ),
    
    //! Ruta para Dog Breeds - Detalle
    GoRoute(
      path: '/dog_breeds_detail',
      name: 'dog_breeds_detail',
      builder: (context, state) {
        final breed = state.extra as DogBreed; // ✅ Ahora DogBreed está importado
        return BreedDetailScreen(breed: breed);
      },
    ),
  ],
);