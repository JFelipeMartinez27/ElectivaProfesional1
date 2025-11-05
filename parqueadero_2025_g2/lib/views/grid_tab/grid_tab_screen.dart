import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/custom_drawer.dart';

class GridTabScreen extends StatefulWidget {
  const GridTabScreen({super.key});

  @override
  State<GridTabScreen> createState() => _GridTabScreenState();
}

class _GridTabScreenState extends State<GridTabScreen> {
  List<String> board = List.filled(9, ""); // tablero 3x3 vacío
  String currentPlayer = "X";

  void _handleTap(int index) {
    if (board[index] == "") {
      setState(() {
        board[index] = currentPlayer;
        currentPlayer = currentPlayer == "X" ? "O" : "X";
      });
    }
  }

  void _resetGame() {
    setState(() {
      board = List.filled(9, "");
      currentPlayer = "X";
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Triki (Grid + TabBar)"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.grid_on), text: "Juego"),
            ],
          ),
          actions: [
            Builder(
              builder: (ctx) => IconButton(
                tooltip: 'Menú',
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(ctx).openDrawer(),
              ),
            ),
          ],
        ),
        drawer: const CustomDrawer(),
        body: TabBarView(
          children: [
            Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return ElevatedButton(
                        onPressed: () => _handleTap(index),
                        child: Text(
                          board[index],
                          style: const TextStyle(fontSize: 32),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _resetGame,
                  child: const Text("Reiniciar juego"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    context.go('/'); // 👈 te lleva a la ruta de inicio
                  },
                  child: const Text("Volver al inicio"),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
