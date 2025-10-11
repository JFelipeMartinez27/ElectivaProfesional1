import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // ✅ AGREGAR ESTA IMPORTACIÓN
import '../../models/dog_breed.dart';
import '../../services/dog_service.dart';
import '../../widgets/custom_drawer.dart';

class BreedDetailScreen extends StatefulWidget {
  final DogBreed breed;

  const BreedDetailScreen({super.key, required this.breed});

  @override
  State<BreedDetailScreen> createState() => _BreedDetailScreenState();
}

class _BreedDetailScreenState extends State<BreedDetailScreen> {
  final DogService _dogService = DogService();
  List<String> _breedImages = [];
  bool _isLoadingImages = false;

  // ✅ SOLUCIÓN: Usar GlobalKey para el Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadBreedImages();
  }

  Future<void> _loadBreedImages() async {
    try {
      setState(() {
        _isLoadingImages = true;
      });

      final images = await _dogService.getBreedImages(widget.breed.name, 5);
      
      setState(() {
        _breedImages = images;
        _isLoadingImages = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingImages = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error cargando imágenes: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ AGREGAR LA KEY AL SCAFFOLD
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_capitalize(widget.breed.name)),
        backgroundColor: const Color.fromARGB(255, 79, 243, 33),
        foregroundColor: Colors.white,
        // ✅ CORREGIDO: Usar la key en lugar de Scaffold.of(context)
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // ← Cambié el ícono a "atrás"
          onPressed: () {
            // ✅ CORREGIDO: Usar GoRouter.of(context).pop para volver atrás
            GoRouter.of(context).pop();
          },
        ),
        // ✅ AGREGAR BOTÓN DE MENÚ AL LADO DERECHO
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen principal
            if (widget.breed.imageUrl.isNotEmpty)
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.breed.imageUrl),
                  radius: 80,
                ),
              ),
            
            const SizedBox(height: 24),
            
            // Información de la raza
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Raza: ${_capitalize(widget.breed.name)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Sub-razas: ${widget.breed.subBreeds.isNotEmpty ? widget.breed.subBreeds.map(_capitalize).join(', ') : 'Ninguna'}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Número de sub-razas: ${widget.breed.subBreeds.length}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Más imágenes
            const Text(
              'Más Imágenes:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            
            _isLoadingImages
                ? const Center(child: CircularProgressIndicator())
                : _breedImages.isNotEmpty
                    ? SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _breedImages.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(_breedImages[index]),
                                radius: 50,
                              ),
                            );
                          },
                        ),
                      )
                    : const Text('No hay imágenes adicionales disponibles'),
          ],
        ),
      ),
    );
  }
}