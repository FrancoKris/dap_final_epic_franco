// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dap_final_franco/providers/provider.dart';
import 'package:dap_final_franco/entities/saga.dart';
import 'package:dap_final_franco/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

class DetailScreen extends ConsumerWidget {
  static const String name = 'detalles';
  DetailScreen({super.key});
  TextEditingController nombreController = TextEditingController();
  TextEditingController cancionesController = TextEditingController();
  TextEditingController imagenController = TextEditingController();
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context, ref) {
    final List<Saga> listaSagas = ref.watch(sagaProvider);
    final index = ref.watch(indexSagaSeleccionado);

    bool modoAgregar;
    if (index != -1) {
      nombreController.text = listaSagas[index].nombre;
      cancionesController.text = listaSagas[index].canciones;
      imagenController.text = listaSagas[index].imagen;
      modoAgregar = false;
    } else {
      modoAgregar = true;
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 350,
              child: TextField(
                controller: nombreController,
                decoration: const InputDecoration(
                  hintText: "Nombre de la saga de Epic",
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: 350,
              child: TextField(
                controller: cancionesController,
                decoration: const InputDecoration(
                  hintText: "Canciones de la saga de Epic",
                ),
              ),
            ),
            
            SizedBox(
              height: 50,
              width: 350,
              child: TextField(
                controller: imagenController,
                decoration: const InputDecoration(
                  hintText: "Link a la imagen de la saga de Epic",
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (modoAgregar) {
                  ref.read(sagaProvider.notifier).subirDatos(
                        nombreController.text,
                        cancionesController.text,
                        imagenController.text,
                      );
                } else {
                  ref.read(sagaProvider.notifier).modificarDatos(
                        listaSagas[index].id,
                        nombreController.text,
                        cancionesController.text,
                        imagenController.text,                        
                      );
                }
                context.pushNamed(HomeScreen.name);
              },
              child: Text(
                modoAgregar ? "Agregar" : "Modificar",
              ),
            ),
            const SizedBox(height: 10),
            if (!modoAgregar)
              ElevatedButton(
                onPressed: () {
                  db.collection("Saga").doc(listaSagas[index].id).delete();
                  context.pushNamed(HomeScreen.name);
                },
                child: const Text(
                  "Eliminar",
                ),
              ),
          ],
        ),
      ),
    );
  }
}
