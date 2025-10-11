import 'dart:async';
import 'package:flutter/material.dart';

import '../../widgets/base_view.dart';

class Platos {
  final String nombre;
  final String fotografiaUrl;
  Platos(this.nombre, this.fotografiaUrl);
}

String _mensaje = "Cargando…";
bool _hayError = false;

class FutureView extends StatefulWidget {
  const FutureView({super.key});

  @override
  State<FutureView> createState() => _FutureViewState();
}

class _FutureViewState extends State<FutureView> {
  List<Platos> _platos = []; // declarar una lista.

  @override
  // !inicializa el estado
  void initState() {
    super.initState();
    obtenerDatos(); // carga al iniciar
  }

  // !Funcion que simula una carga de datos
  //*espera 2 segundos antes de cargar los datos, esto simula una carga de datos.
  Future<List<Platos>> cargarPlatos() async {
    //future.delayed() simula una carga de datos
    await Future.delayed(const Duration(seconds: 2));
    return [
      Platos(
        'Solomillo de cerdo',
        'https://media.hellofresh.com/c_fit,f_auto,fl_lossy,h_500,q_50,w_1900/hellofresh_s3/image/HF_Y24_R16_W36_ES_ESSGP26858-2_Main_R_swap_salad_mix_edit_high-75970936.jpg',
      ),
      Platos(
        'Dorada con salsa',
        'https://media.hellofresh.com/c_fit,f_auto,fl_lossy,h_500,q_50,w_1900/hellofresh_s3/image/HF_Y24_R16_W35_ES_ESSGF27673-2_Main__7high-b733fe61.jpg',
      ),
      Platos(
        'Pato a la naranja',
        'https://media.hellofresh.com/c_fit,f_auto,fl_lossy,h_500,q_50,w_1900/hellofresh_s3/image/HF_Y24_R16_W21_ES_ESSGD21023-2_edit_veggies_Main__9high-ebc0890a.jpg',
      ),
      Platos(
        'Yakiniku',
        'https://media.hellofresh.com/c_fit,f_auto,fl_lossy,h_500,q_50,w_1900/hellofresh_s3/image/HF_Y24_R16_W31_ES_ESSGB21287-2_Main_high-d9f1ba34.jpg',
      ),
      
      //throw Exception("Simulación de error"); // Descomentar esta línea para simular un error
    ];
  }

  // !Funcion que obtiene los datos
  // *carga los datos y los asigna a la lista _platos
  Future<void> obtenerDatos() async {
    print("🔵 ANTES de la carga de platos"); // Antes de la carga
    setState(() {
      _mensaje = "Cargando…";
      _hayError = false;
    });
    try {
      print("🟡 DURANTE la carga de platos"); // Durante la carga
      final datos = await cargarPlatos();
      if (!mounted) return;
      setState(() {
        _platos = datos;
        _mensaje = "¡Éxito!";
        _hayError = false;
      });
      print("🟢 DESPUÉS de la carga de platos (éxito)"); // Después de la carga
    } catch (e) {
      setState(() {
        _mensaje = "Error al cargar los platos";
        _hayError = true;
      });
      print("🔴 DESPUÉS de la carga de platos (error)"); // Después de la carga
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Platos',
      body: _platos.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!_hayError) const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(_mensaje, style: const TextStyle(fontSize: 18)),
                  if (_hayError)
                    ElevatedButton(
                      onPressed: obtenerDatos,
                      child: const Text("Reintentar"),
                    ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                itemCount: _platos.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final plato = _platos[index];
                  return Card(
                    //color: const Color.fromARGB(255, 87, 194, 180),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            plato.fotografiaUrl,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.person, size: 60),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          plato.nombre,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
