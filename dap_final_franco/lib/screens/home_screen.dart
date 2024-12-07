import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:dap_final_franco/entities/saga.dart';
import 'package:dap_final_franco/screens/details_screen.dart';
import 'package:dap_final_franco/providers/provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String name = 'home';
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(sagaProvider.notifier).obtenerDatos();
  }

  @override
  Widget build(BuildContext context) {
    final List<Saga> listaSaga = ref.watch(sagaProvider);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: listaSaga.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(listaSaga[index].nombre),
                    subtitle: Text(listaSaga[index].canciones),
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.network(listaSaga[index].imagen),
                      ),
                    onTap: () {
                      ref.read(indexSagaSeleccionado.notifier).state = index;
                      context.pushNamed(DetailScreen.name);
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ref.read(indexSagaSeleccionado.notifier).state = -1;
              context.pushNamed(DetailScreen.name);
            },
            child: const Icon(
              Icons.edit,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
