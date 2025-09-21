"# ElectivaProfesional1" 
- Drawer: menú lateral para navegación entre pantallas.
- TabBar: para organizar secciones dentro de una misma pantalla.
- GridView: para mostrar un tablero estilo Triki (Tic Tac Toe) interactivo.
- Botón extra: permite volver fácilmente a la ventana principal.

La aplicación está organizada en carpetas, lo que facilita la mantenibilidad:

- main.dart: punto de entrada principal de la aplicación.
- routes/app_router.dart: archivo donde se definen todas las rutas con GoRouter.
- widgets/custom_drawer.dart: contiene el menú lateral (Drawer).
- views/grid_tab/grid_tab_screen.dart: pantalla del juego Triki implementado con GridView y TabBar.
- Otras vistas: como home_screen, ciclo_vida_screen y paso_parametros_screen
  
1. Drawer (Menú lateral)
El Drawer se usa para navegar a distintas pantallas. Se agregó un ListTile que abre la pantalla de Triki
2. TabBar
Se utilizó DefaultTabController con TabBar y TabBarView. La TabBar maneja una pestaña llamada Juego, pero se puede escalar a más secciones.
3. GridView (Tablero Triki 3x3)
El tablero está hecho con GridView.builder.
- Se genera una cuadrícula de 3x3.
- Cada celda es un botón (ElevatedButton).
- Los valores alternan entre X y O según el turno
4. Botones adicionales
1. Reiniciar juego: limpia el tablero y reinicia el turno a X.
2. Volver al inicio: redirige a la pantalla principal usando GoRouter.

Los tres widgets que se utilizaron, se buscaron para que pudieran ser implementados en una sola ventana, para hacerlo de froma creativa e interactiva, por ende se selecciono no lo el widget, si no tambine un juego comun y sencilla de la infancia

