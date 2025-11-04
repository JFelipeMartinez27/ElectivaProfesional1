
Dog Breeds App

## API Utilizada
- **Dog CEO API**: https://dog.ceo/dog-api/
- **Endpoint principal**: `https://dog.ceo/api/breeds/list/all`
- **Ejemplo de respuesta JSON**:
```json
{
  "message": {
    "affenpinscher": [],
    "bulldog": ["boston", "english", "french"]
  },
  "status": "success"
Arquitectura
lib/
├── models/dog_breed.dart
├── services/dog_service.dart
├── views/dog_view/
│   ├── breed_list_screen.dart
│   └── breed_detail_screen.dart
└── routes/app_router.dart
| Requisito | Estado |
|-----------|--------|
| ✅ Manejo errores try/catch | **CUMPLIDO** |
| ✅ Verificación statusCode | **CUMPLIDO** |
| ✅ Estados cargando/éxito/error | **CUMPLIDO** |
| ✅ No peticiones en build() | **CUMPLIDO** |
| ✅ No bloquear UI | **CUMPLIDO** |
| ✅ Mensajes claros al usuario | **CUMPLIDO** |
