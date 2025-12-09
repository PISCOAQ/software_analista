import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_analista/domain/models/percorso.dart';
import 'package:software_analista/ui/viewmodels/lista_percorsiViewmodel.dart';

class Lista_percorsiScreen extends StatelessWidget {
  const Lista_percorsiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => lista_percorsiViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Elenco Percorsi'),
        ),
        body: Consumer<lista_percorsiViewModel>(
          builder: (context, vm, child) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (vm.percorsi.isEmpty) {
              return const Center(child: Text('Nessun percorso disponibile'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: vm.percorsi.length,
              itemBuilder: (context, index) {
                final Percorso percorso = vm.percorsi[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(percorso.nome),
                    subtitle: Text(
                        'Nodi: ${percorso.numNodi}, Inizio: ${percorso.dataInizio.toLocal().toString().split(' ')[0]}'),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      // Qui si può navigare alla pagina di dettaglio del percorso
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
