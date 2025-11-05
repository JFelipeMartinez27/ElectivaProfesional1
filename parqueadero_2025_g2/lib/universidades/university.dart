class University {
  final String id; // Firestore doc id
  final String nit;
  final String nombre;
  final String direccion;
  final String telefono;
  final String paginaWeb;

  University({
    required this.id,
    required this.nit,
    required this.nombre,
    required this.direccion,
    required this.telefono,
    required this.paginaWeb,
  });

  factory University.fromMap(String id, Map<String, dynamic> data) {
    return University(
      id: id,
      nit: (data['nit'] ?? '').toString(),
      nombre: (data['nombre'] ?? '').toString(),
      direccion: (data['direccion'] ?? '').toString(),
      telefono: (data['telefono'] ?? '').toString(),
      paginaWeb: (data['pagina_web'] ?? data['paginaWeb'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toMap() => {
        'nit': nit,
        'nombre': nombre,
        'direccion': direccion,
        'telefono': telefono,
        'pagina_web': paginaWeb,
      };
}
