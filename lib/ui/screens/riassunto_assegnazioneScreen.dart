import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_analista/data/repository/assegna_percorsoRepository.dart';
import 'package:software_analista/domain/models/bambino.dart';
import 'package:software_analista/domain/models/percorso.dart';
import 'package:software_analista/ui/viewmodels/assegna_percorsoViewmodel.dart';
import 'package:software_analista/ui/widgets/BambinoCard.dart';
import 'package:software_analista/ui/widgets/Sidebar.dart';
import 'package:software_analista/ui/widgets/Topbar.dart';
import 'package:software_analista/ui/widgets/percorso_card.dart';

class AssegnazioneRiassuntoScreen extends StatelessWidget {
  final Bambino bambino;
  final Percorso percorso;

  const AssegnazioneRiassuntoScreen({
    super.key,
    required this.bambino,
    required this.percorso,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AssegnaPercorsoViewModel>(
      create: (_) => AssegnaPercorsoViewModel(
        Provider.of<AssegnaPercorsoRepository>(context, listen: false), // repository passato tramite Provider
      )
        ..selezionaBambino(bambino)
        ..selezionaPercorso(percorso),
      child: Consumer<AssegnaPercorsoViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Row(
              children: [
                Sidebar(),
                Expanded(
                  child: Column(
                    children: [
                      TopBar(),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: BambinoCard(bambino: vm.bambino!)),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Icon(
                                Icons.arrow_forward,
                                size: 32,
                                color: Colors.blue,
                              ),
                            ),
                            Expanded(child: percorso_card(percorso: vm.percorso!)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: vm.isLoading
                                  ? null
                                  : () async {
                                      await vm.confermaAssociazione();
                                      if (vm.errore == null) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Percorso assegnato correttamente',
                                            ),
                                          ),
                                        );
                                        Navigator.pop(context); // torna alla lista
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(vm.errore!),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    },
                              child: vm.isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text('Conferma Assegnazione'),
                            ),
                            const SizedBox(height: 12),
                            if (vm.errore != null)
                              Text(
                                vm.errore!,
                                style: const TextStyle(color: Colors.red),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
