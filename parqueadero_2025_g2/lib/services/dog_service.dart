import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dog_breed.dart';

class DogService {
  static const String _baseUrl = 'https://dog.ceo/api';

  Future<List<DogBreed>> getAllBreeds() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/breeds/list/all'));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final Map<String, dynamic> breedsMap = data['message'];
        
        List<DogBreed> breeds = [];
        
        // Obtener primeras 15 razas para mejor performance
        int count = 0;
        for (var breedName in breedsMap.keys) {
          if (count >= 15) break;
          
          final imageUrl = await getBreedImage(breedName);
          final subBreeds = List<String>.from(breedsMap[breedName] ?? []);
          
          breeds.add(DogBreed(
            name: breedName,
            subBreeds: subBreeds,
            imageUrl: imageUrl,
          ));
          count++;
        }
        
        return breeds;
      } else {
        throw Exception('Error al cargar razas: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching breeds: $e');
    }
  }

  Future<String> getBreedImage(String breedName) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/breed/$breedName/images/random')
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['message'] ?? '';
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  Future<List<String>> getBreedImages(String breedName, int count) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/breed/$breedName/images/random/$count')
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return List<String>.from(data['message'] ?? []);
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}