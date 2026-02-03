import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_analista/ui/screens/selezione_percorsoScreen.dart';
import 'package:software_analista/ui/viewmodels/lista_bambiniViewmodel.dart';
import 'package:software_analista/ui/widgets/BambinoCard.dart';
import 'package:software_analista/ui/widgets/Topbar.dart';
import 'package:software_analista/ui/widgets/Sidebar.dart';
import 'package:software_analista/domain/models/bambino.dart';

class SelezioneBambinoScreen extends StatefulWidget {
  const SelezioneBambinoScreen({super.key});

  @override
  State<SelezioneBambinoScreen> createState() => _SelezioneBambinoScreenState();
}

class _SelezioneBambinoScreenState extends State<SelezioneBambinoScreen> {
  Bambino? bambinoSelezionato;
  String ricerca = "";

  @override
  Widget build(BuildContext context) {
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
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Cerca utente...',
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
                  child: Consumer<lista_bambiniViewmodel>(
                    builder: (context, vm, _) {
                      final listaFiltrata = vm.bambini.where((b) {
                        final nome = b.nome.toLowerCase();
                        final cognome = b.cognome.toLowerCase();
                        return nome.contains(ricerca) || cognome.contains(ricerca);
                      }).toList();

                      return ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: listaFiltrata.length,
                        itemBuilder: (context, index) {
                          final bambino = listaFiltrata[index];
                          return BambinoCard(
                            bambino: bambino,
                            onTap: () {
                              setState(() {
                                bambinoSelezionato = bambino;
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
                    onPressed: bambinoSelezionato != null
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SelezionePercorsoScreen(
                                  bambinoSelezionato: bambinoSelezionato!,
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
