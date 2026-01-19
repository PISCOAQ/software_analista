import 'package:flutter/material.dart';
import 'package:software_analista/domain/models/bambino.dart';
import 'package:software_analista/domain/models/percorso.dart';
import 'package:software_analista/ui/screens/riassunto_assegnazioneScreen.dart';
import 'package:software_analista/ui/widgets/Sidebar.dart';
import 'package:software_analista/ui/widgets/Topbar.dart';
import 'package:provider/provider.dart';
import 'package:software_analista/ui/viewmodels/lista_percorsiViewmodel.dart';
import 'package:software_analista/ui/widgets/percorso_card.dart';

class SelezionePercorsoScreen extends StatefulWidget {
  final Bambino bambinoSelezionato;
  const SelezionePercorsoScreen({super.key, required this.bambinoSelezionato});

  @override
  State<SelezionePercorsoScreen> createState() => _SelezionePercorsoScreenState();
}

class _SelezionePercorsoScreenState extends State<SelezionePercorsoScreen> {
  Percorso? percorsoSelezionato;
  String ricerca = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(),
          Expanded(
            child: Column(
              children: [
                TopBar(),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Cerca percorso...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (val) {
                      setState(() {
                        ricerca = val.toLowerCase();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Consumer<lista_percorsiViewModel>(
                    builder: (context, vm, _) {
                      final listaFiltrata = vm.percorsi.where((p) {
                        return p.nome.toLowerCase().contains(ricerca);
                      }).toList();

                      return ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: listaFiltrata.length,
                        itemBuilder: (context, index) {
                          final percorso = listaFiltrata[index];
                          return percorso_card(
                            percorso: percorso,
                            onTap: () {
                              setState(() {
                                percorsoSelezionato = percorso;
                              });
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ElevatedButton(
                    onPressed: percorsoSelezionato != null
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AssegnazioneRiassuntoScreen(
                                  bambino: widget.bambinoSelezionato,
                                  percorso: percorsoSelezionato!,
                                ),
                              ),
                            );
                          }
                        : null,
                    child: const Text('Continua'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
