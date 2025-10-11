import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';
import '../../widgets/base_view.dart';

class IsolateView extends StatefulWidget {
  const IsolateView({super.key});

  @override
  State<IsolateView> createState() => _IsolateViewState();
}

class _IsolateViewState extends State<IsolateView> {
  String resultado =
      "Presiona el botón para calcular la suma de calorias de los platos.";
  String tiempoInicio = "";
  String tiempoFin = "";
  String duracion = "";

  // Implementa una función CPU-bound: suma de calorias de platos
  Future<void> calcularSumaCalorias() async {
    final receivePort = ReceivePort();

    print("🟢 [MAIN] Iniciando cálculo en Isolate...");
    setState(() {
      resultado = "Calculando...";
      tiempoInicio = DateTime.now().toString();
      tiempoFin = "";
      duracion = "";
    });

    final start = DateTime.now();

    // Lanza el Isolate y pasa el SendPort principal
    await Isolate.spawn(_tareaSumaVelocidades, receivePort.sendPort);

    // Espera el SendPort del Isolate
    final sendPort = await receivePort.first as SendPort;

    // Crea un canal para recibir la respuesta
    final response = ReceivePort();

    // Datos de ejemplo: calorías de platos
    final platos = [
      {"nombre": "Solomillo de cerdo", "calorias": 1252},
      {"nombre": "Dorada con salsa", "calorias": 1349},
      {"nombre": "Pato a la naranja", "calorias": 850},
      {"nombre": "Yakinku", "calorias": 1047},
    ];

    // Envía los datos y el puerto de respuesta al Isolate
    sendPort.send([platos, response.sendPort]);

    // Espera la respuesta del Isolate
    final result = await response.first as String;

    final end = DateTime.now();
    final diff = end.difference(start);

    print("🔵 [MAIN] Cálculo terminado. Duración: ${diff.inMilliseconds} ms");

    if (!mounted) return;
    setState(() {
      resultado = result;
      tiempoFin = end.toString();
      duracion = "${diff.inMilliseconds} ms";
    });
  }

  // Función que se ejecuta en el Isolate
  static void _tareaSumaVelocidades(SendPort sendPort) async {
    final port = ReceivePort();
    sendPort.send(port.sendPort);

    await for (final message in port) {
      print("🟡 [ISOLATE] Recibidos datos, iniciando suma...");
      final List<dynamic> platos = message[0] as List<dynamic>;
      final SendPort replyPort = message[1] as SendPort;

      int suma = 0;
      String listaPlatos = "";
      for (var plato in platos) {
        suma += plato["calorias"] as int;
        listaPlatos += "${plato["nombre"]}: ${plato["calorias"]} calorías\n";
      }
      final promedio = (suma / platos.length).toStringAsFixed(2);

      final resultado =
          "Platos y sus calorías:\n\n"
          "$listaPlatos\n"
          "Suma total de calorías: $suma\n"
          "Promedio: $promedio calorías";

      print("🟣 [ISOLATE] Suma y promedio calculados, enviando resultado...");
      replyPort.send(resultado);
      port.close();
      Isolate.exit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: "Calorias Platos",
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: Image(
                  image: NetworkImage(
                    'https://s1.elespanol.com/2015/03/31/cocinillas/cocinillas_22257914_116018277_1706x960.jpg',
                  ),
                  width: 250,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                resultado,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              if (tiempoInicio.isNotEmpty)
                Text(
                  "⏱️ Inicio: $tiempoInicio",
                  style: const TextStyle(fontSize: 14),
                ),
              if (tiempoFin.isNotEmpty)
                Text(
                  "🏁 Fin: $tiempoFin",
                  style: const TextStyle(fontSize: 14),
                ),
              if (duracion.isNotEmpty)
                Text(
                  "🕒 Duración: $duracion",
                  style: const TextStyle(fontSize: 14),
                ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: calcularSumaCalorias,
                icon: const Icon(Icons.speed),
                label: const Text("Calcular suma y promedio"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  minimumSize: const Size(200, 48),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
