import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_analista/datiFinti/dati.dart';
import 'package:software_analista/domain/enums/extensions_scuola.dart';
import 'package:software_analista/domain/enums/extensions_titoloStudio.dart';
import 'package:software_analista/domain/enums/sesso.dart';
import 'package:software_analista/ui/viewmodels/dashboard_bambinoViewmodel.dart';
import 'package:software_analista/domain/models/bambino.dart';
import 'package:software_analista/ui/widgets/grafico_bubble.dart';
import 'package:software_analista/ui/widgets/grafico_area.dart';
import 'package:software_analista/ui/widgets/grafico_barre.dart';
import 'package:software_analista/ui/widgets/grafico_lineare.dart';
import 'package:software_analista/ui/widgets/grafico_radialBar.dart';
import 'package:software_analista/ui/widgets/grafico_scatter.dart';
import 'package:software_analista/ui/widgets/grafico_torta.dart';
import 'package:software_analista/ui/widgets/Sidebar.dart';
import 'package:software_analista/ui/widgets/Topbar.dart';

class Dashboard_bambinoScreen extends StatelessWidget {
  final Bambino bambino;

  const Dashboard_bambinoScreen({
    super.key,
    required this.bambino,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => dashboard_bambinoViewModel(bambino: bambino),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: [
            /// SIDEBAR
            Sidebar(),

            /// CONTENUTO PRINCIPALE
            Expanded(
              child: Column(
                children: [
                  /// TOPBAR
                  TopBar(),

                  /// CONTENUTO DASHBOARD
                  Expanded(
                    child: Consumer<dashboard_bambinoViewModel>(
                      builder: (context, vm, _) {
                        if (vm.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final Bambino bambino = vm.bambino;

                        return SingleChildScrollView(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// NOME + COGNOME
                              Text(
                                "${bambino.nome} ${bambino.cognome}",
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 16),

                              /// DATI BAMBINO (NUOVA SEZIONE)
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Dati utente",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    Row(
                                      children: [
                                        _infoItem(
                                          label: "Data di nascita",
                                          value: _formatDate(bambino.dataDiNascita),
                                        ),
                                        _infoItem(
                                          label: "Sesso",
                                          value: _formatSesso(bambino.sesso),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        _infoItem(
                                          label: "Scuola Frequentata",
                                          value: bambino.scuolaFrequentata.label,
                                        ),
                                        _infoItem(
                                          label: "Titolo di studio",
                                          value: bambino.titoloStudio.label,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        _infoItem(
                                          label: "Codice utente",
                                          value: bambino.codiceGioco.toString(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 32),
                              /// 🗂 Tabella test del bambino
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
                                  child: DataTable(
                                    headingRowColor: MaterialStateColor.resolveWith((states) => Colors.black),
                                    headingTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    columnSpacing: 20,
                                    dividerThickness: 1,
                                    columns: const [
                                      DataColumn(label: Text("Test Pre-Esercitazione")),        // Prima colonna
                                      DataColumn(label: Text("Risultato")),
                                      DataColumn(label: Text('Tempo medio di reazione')),
                                      DataColumn(label: Text('Movimento del mouse')),
                                      DataColumn(label: Text('Metodo di interazione'))
                                    ],
                                    rows: List.generate(5, (index) {
                                      final nomeTestpre= "Test Pre-Esercitazione";
                                      return DataRow(
                                        cells: [
                                          DataCell(
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              child: Text(
                                                nomeTestpre,
                                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          DataCell(Text('Risultato')),
                                          DataCell(Text('Tempo medio di reazione')),
                                          DataCell(Text('Movimento del mouse')),
                                          DataCell(Text('Metodo di interazione'))
                                        ]
                                      );
                                    }),
                                    border: TableBorder.symmetric(
                                      inside: const BorderSide(color: Colors.black, width: 1), // linee tra colonne
                                      outside: const BorderSide(color: Colors.black, width: 1), // bordo esterno
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),

                              /// 2 tabella
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
                                  child: DataTable(
                                    headingRowColor: MaterialStateColor.resolveWith((states) => Colors.black),
                                    headingTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    columnSpacing: 20,
                                    dividerThickness: 1,
                                    columns: const [
                                      DataColumn(label: Text("Test Post-Esercitazione")),        // Prima colonna
                                      DataColumn(label: Text("Risultato")),
                                      DataColumn(label: Text('Tempo medio di reazione')),
                                      DataColumn(label: Text('Movimento del mouse')),
                                      DataColumn(label: Text('Metodo di interazione'))
                                    ],
                                    rows: List.generate(5, (index) {
                                      final nomeTestpost = "Test Post-Esercitazione";
                                      return DataRow(
                                        cells: [
                                          DataCell(
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              child: Text(
                                                nomeTestpost,
                                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          DataCell(Text('Risultato')),
                                          DataCell(Text('Tempo medio di reazione')),
                                          DataCell(Text('Movimento del mouse')),
                                          DataCell(Text('Metodo di interazione'))
                                        ]
                                      );
                                    }),
                                    border: TableBorder.symmetric(
                                      inside: const BorderSide(color: Colors.black, width: 1), // linee tra colonne
                                      outside: const BorderSide(color: Colors.black, width: 1), // bordo esterno
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),

                              LineChartWidget(
                                data: vm.getProgressiChartData(),
                              ),

                              const SizedBox(height: 32),

                              /// 📌 RIEPILOGO PERCORSI
                              const Text(
                                "Riepilogo Percorsi",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),

                              Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (bambino.progressoBambino == null)
                                        const Text(
                                          "Nessun percorso iniziato",
                                          style: TextStyle(fontSize: 16),
                                        )
                                      else Builder(
                                        builder: (context) {
                                          final progresso =
                                              bambino.progressoBambino!;
                                          final percorso =
                                              getPercorsoById(progresso.percorsoId);

                                          if (percorso == null) {
                                            return const Text(
                                              "Percorso non trovato",
                                              style: TextStyle(fontSize: 16),
                                            );
                                          }

                                          return Text(
                                            "• ${percorso.nome} "
                                            "(${progresso.nodiCompletati}/${percorso.numNodi})",
                                            style: const TextStyle(fontSize: 16),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget riutilizzabile per i dati
  Widget _infoItem({required String label, required String value}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  String _formatSesso(Sesso sesso) {
    switch (sesso) {
      case Sesso.maschio:
        return "Maschio";
      case Sesso.femmina:
        return "Femmina";
    }
  }
}
