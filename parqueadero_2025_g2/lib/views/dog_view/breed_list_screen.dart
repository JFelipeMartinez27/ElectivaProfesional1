import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // ✅ AGREGAR ESTA IMPORTACIÓN
import '../../models/dog_breed.dart';
import '../../services/dog_service.dart';
import '../../widgets/custom_drawer.dart';

class BreedListScreen extends StatefulWidget {
  const BreedListScreen({super.key});

  @override
  State<BreedListScreen> createState() => _BreedListScreenState();
}

class _BreedListScreenState extends State<BreedListScreen> {
  final DogService _dogService = DogService();
  List<DogBreed> _breeds = [];
  bool _isLoading = true;
  String _errorMessage = '';

  // ✅ SOLUCIÓN: Usar GlobalKey para el Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadBreeds();
  }

  Future<void> _loadBreeds() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      final breeds = await _dogService.getAllBreeds();
      
      setState(() {
        _breeds = breeds;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error cargando razas: $e';
        _isLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _navigateToDetail(DogBreed breed) {
    // ✅ CORREGIDO: Usar GoRouter.of(context).push
    GoRouter.of(context).push('/dog_breeds_detail', extra: breed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ AGREGAR LA KEY AL SCAFFOLD
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Razas de Perros'),
        backgroundColor: const Color.fromARGB(255, 79, 243, 33),
        foregroundColor: Colors.white,
        // ✅ CORREGIDO: Usar la key en lugar de Scaffold.of(context)
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: const CustomDrawer(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadBreeds,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Cargando razas de perros...'),
          ],
        ),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              _errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadBreeds,
              child: const Text('Intentar Nuevamente'),
            ),
          ],
        ),
      );
    }

    if (_breeds.isEmpty) {
      return const Center(
        child: Text('No se encontraron razas'),
      );
    }

    return ListView.builder(
      itemCount: _breeds.length,
      itemBuilder: (context, index) {
        final breed = _breeds[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: ListTile(
            leading: breed.imageUrl.isNotEmpty
                ? CircleAvatar(
                    backgroundImage: NetworkImage(breed.imageUrl),
                    radius: 25,
                  )
                : const CircleAvatar(
                    child: Icon(Icons.pets),
                  ),
            title: Text(
              _capitalize(breed.name),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              breed.subBreeds.isNotEmpty 
                  ? 'Sub-razas: ${breed.subBreeds.map(_capitalize).join(', ')}'
                  : 'Sin sub-razas',
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => _navigateToDetail(breed),
          ),
        );
      },
    );
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}