class DogBreed {
  final String name;
  final List<String> subBreeds;
  final String imageUrl;

  DogBreed({
    required this.name,
    required this.subBreeds,
    required this.imageUrl,
  });

  factory DogBreed.fromJson(Map<String, dynamic> json, String imageUrl) {
    return DogBreed(
      name: json['name'] ?? '',
      subBreeds: List<String>.from(json['subBreeds'] ?? []),
      imageUrl: imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'subBreeds': subBreeds,
      'imageUrl': imageUrl,
    };
  }

  factory DogBreed.fromMap(Map<String, dynamic> map) {
    return DogBreed(
      name: map['name'] ?? '',
      subBreeds: List<String>.from(map['subBreeds'] ?? []),
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}