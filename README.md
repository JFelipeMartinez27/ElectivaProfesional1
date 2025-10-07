"# ElectivaProfesional1" 
Future

Un Future representa una operación asíncrona que devolverá un resultado en el futuro, similar a una promesa.
Se utiliza cuando una tarea puede tardar (por ejemplo, leer un archivo, hacer una petición HTTP o consultar una base de datos).

Ejemplo:

Future<String> cargarDatos() {
  return Future.delayed(Duration(seconds: 2), () => 'Datos cargados');
}


Cuándo usarlo:
Cuando una función necesita devolver un valor después de que termine un proceso asíncrono.

 async / await

Las palabras clave async y await permiten escribir código asíncrono de forma más legible, sin anidar demasiados then().

Ejemplo:

Future<void> obtenerUsuario() async {
  var datos = await cargarDatos();
  print(datos);
}


Cuándo usarlo:
Cuando quieres esperar el resultado de un Future antes de continuar la ejecución, sin bloquear la interfaz de usuario.

Timer

El Timer sirve para ejecutar una función después de un tiempo determinado o de forma periódica.

Ejemplo:

Timer(Duration(seconds: 3), () {
  print('Han pasado 3 segundos');
});


Cuándo usarlo:
Cuando necesitas retrasar una acción o repetirla periódicamente (por ejemplo, actualizar el estado cada cierto tiempo).

Isolate

Un Isolate permite ejecutar código en un hilo separado del principal (UI).
Dart usa un solo hilo por defecto, por lo que los Isolates son útiles para tareas muy pesadas o que bloquean la interfaz, como cálculos complejos o procesamiento de imágenes.

Ejemplo:

import 'dart:isolate';

void tareaPesada(SendPort sendPort) {
  int suma = 0;
  for (int i = 0; i < 100000000; i++) {
    suma += i;
  }
  sendPort.send(suma);
}


Cuándo usarlo:
Cuando tienes tareas que consumen muchos recursos y quieres mantener la aplicación fluida mientras se ejecutan.
