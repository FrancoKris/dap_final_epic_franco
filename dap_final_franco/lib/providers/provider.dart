import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dap_final_franco/entities/saga.dart';

StateProvider<int> indexSagaSeleccionado = StateProvider((ref) => -1);

final sagaProvider = StateNotifierProvider<SagaNotfiier, List<Saga>>(
  (ref) => SagaNotfiier(),
);

class SagaNotfiier extends StateNotifier<List<Saga>> {
  SagaNotfiier() : super([]);

  final db = FirebaseFirestore.instance;

  Future<void> obtenerDatos() async {
    try {
      final querySnapshot = await db.collection("Saga").get();
      final listaSagas = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Saga(
          doc.id,
          data["nombre"] as String,
          data["canciones"] as String,
          data["imagen"] as String,
        );
      }).toList();
      state = listaSagas;
    } catch (error) {
      print("Error al obtener datos: $error");
    }
  }

  Future<void> subirDatos(nombre, canciones, imagen) async {
    try {
      await db
          .collection("Saga")
          .add({"nombre": nombre, "canciones": canciones, "imagen": imagen});
    } catch (error) {
      print("Error al subir datos: $error");
    }
  }

  Future<void> modificarDatos(id, nombre, canciones, imagen) async {
    try {
      await db.collection("Saga").doc(id).set(
        {"nombre": nombre, "canciones": canciones, "imagen": imagen},
      );
    } catch (error) {
      print("Error al modificar datos: $error");
    }
  }
}
