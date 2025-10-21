# parqueadero_2025_g2

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# Distribución con Firebase App Distribution - Parqueadero 2025 G2

## Flujo de Distribución
1. **Generar APK**: `flutter build apk --release`
2. **App Distribution**: Subir APK a Firebase Console
3. **Testers**: Configurar grupos y agregar testers
4. **Instalación**: Testers reciben enlace vía email
5. **Actualización**: Incrementar versionado y repetir proceso

## Publicación - Pasos Resumidos

### Preparación
```bash
flutter clean
flutter pub get
flutter build apk --release