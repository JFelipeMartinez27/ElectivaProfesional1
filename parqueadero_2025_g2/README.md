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
```

## Evidencias de configuración Firebase (Checklist)

- Proyecto en Firebase Console
  - Ruta: Proyecto `parqueadero-2025-g2` → Configuración (engranaje) → General
  - Captura: Project ID, Project number y sección "Tus apps" con Android `com.example.parqueadero_2025_g2`.

- Firestore Database
  - Ruta: Firestore Database → Datos
  - Captura: Colección `universidades` con documentos y campos.

- Archivo generado por FlutterFire
  - Ruta local: `lib/firebase_options.dart`
  - Captura: Encabezado con `DefaultFirebaseOptions` y `projectId/appId` (puedes difuminar si deseas).

- Inicialización en Flutter
  - Ruta local: `lib/main.dart`
  - Captura: `Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)`

- Dependencias
  - Ruta local: `pubspec.yaml`
  - Captura: `firebase_core`, `cloud_firestore` y `flutter: uses-material-design: true`.

- Android: Identificadores y permisos
  - `android/app/build.gradle.kts`: `applicationId = "com.example.parqueadero_2025_g2"`
  - `android/app/src/main/AndroidManifest.xml`: permisos `INTERNET` y `ACCESS_NETWORK_STATE`.
  - `android/app/google-services.json`: presente y con `package_name` correcto.

- Evidencia CLI (opcional)
  - Comando: `flutterfire configure --project parqueadero-2025-g2 --platforms=android --android-package-name com.example.parqueadero_2025_g2`
  - Captura: salida indicando que generó `lib/firebase_options.dart`.