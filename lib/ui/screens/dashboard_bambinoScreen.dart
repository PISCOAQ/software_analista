import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_analista/data/repository/dashboard_bambinoRepository.dart';
import 'package:software_analista/domain/enums/extensions_scuola.dart';
import 'package:software_analista/domain/enums/extensions_titoloStudio.dart';
import 'package:software_analista/domain/enums/sesso.dart';
import 'package:software_analista/domain/models/diagnosi.dart';
import 'package:software_analista/ui/viewmodels/dashboard_bambinoViewmodel.dart';
import 'package:software_analista/domain/models/bambino.dart';
import 'package:software_analista/ui/widgets/DialogDiagnosi.dart';
import 'package:software_analista/ui/widgets/grafico_lineare.dart';
import 'package:software_analista/ui/widgets/Sidebar.dart';
import 'package:software_analista/ui/widgets/Topbar.dart';
import 'package:flutter/services.dart';

class Dashboard_bambinoScreen extends StatefulWidget {
  final Bambino bambino;
  final DashboardBambinorepository repository;

  const Dashboard_bambinoScreen({
    super.key,
    required this.bambino,
    required this.repository
  });

  @override
  State<Dashboard_bambinoScreen> createState() => _Dashboard_bambinoScreenState();
}

class _Dashboard_bambinoScreenState extends State<Dashboard_bambinoScreen> {
  late DashboardBambinoViewModel _vm;

  @override
  void initState(){
    super.initState();

    _vm = DashboardBambinoViewModel(
      bambino: widget.bambino,
      repository: widget.repository,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _vm.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _vm,
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
                    child: Consumer<DashboardBambinoViewModel>(
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

                              /// DATI BAMBINO
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

                                    // Codice utente con bottone copia
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Codice utente",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Text(
                                                    bambino.codiceGioco.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  InkWell(
                                                    onTap: () {
                                                      Clipboard.setData(
                                                          ClipboardData(
                                                              text: bambino.codiceGioco.toString()));
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        const SnackBar(
                                                          content: Text("Codice copiato negli appunti"),
                                                          duration: Duration(seconds: 1),
                                                        ),
                                                      );
                                                    },
                                                    child: const Icon(
                                                      Icons.copy,
                                                      size: 20,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 16),


                              Align(
                                alignment: Alignment.centerLeft,
                                child: ElevatedButton.icon(                                 
                                  icon: const Icon(Icons.download),
                                  label: const Text("Scarica report Excel"),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                    textStyle: const TextStyle(fontSize: 15),
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white
                                  ),
                                  onPressed: vm.isLoading
                                    ? null
                                    : () async {
                                      try {
                                        await vm.esportaExcel( bambino.id!, bambino.nome );
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("Report Excel scaricato con successo"),
                                          ),
                                        );
                                      } catch (e) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("Errore durante il download del report"),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),

                              const SizedBox(height: 32),

                              /// 📌 TABELLA TEST PRE
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      minWidth: MediaQuery.of(context).size.width),
                                  child: DataTable(
                                    headingRowColor: MaterialStateColor.resolveWith(
                                        (states) => Colors.black),
                                    headingTextStyle: const TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.bold),
                                    columnSpacing: 20,
                                    dividerThickness: 1,
                                    columns: const [
                                      DataColumn(label: Text("Test Pre-Esercitazione")),
                                      DataColumn(label: Text("Risultato")),
                                      DataColumn(label: Text('Tempo medio di reazione')),
                                      DataColumn(label: Text('Movimento del mouse')),
                                      //DataColumn(label: Text('Metodo di interazione'))
                                    ],
                                    rows: vm.testPre.map((test) {
                                      return DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              test.nomeTest,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                        
                                          DataCell(  Text("${test.domandeCorrette} / ${test.totaleDomande}")),
                                          DataCell(Text("${test.tempoMedioReazione.toStringAsFixed(2)} ms"),),
                                          DataCell(Text('${test.movimentoMouse}')),
                                        //const DataCell(Text('Metodo di interazione'))
                                      ]);
                                    }).toList(),
                                    border: TableBorder.symmetric(
                                      inside: const BorderSide(
                                          color: Colors.black, width: 1),
                                      outside: const BorderSide(
                                          color: Colors.black, width: 1),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 32),

                              /// 📌 TABELLA TEST POST
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      minWidth: MediaQuery.of(context).size.width),
                                  child: DataTable(
                                    headingRowColor: MaterialStateColor.resolveWith(
                                        (states) => Colors.black),
                                    headingTextStyle: const TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.bold),
                                    columnSpacing: 20,
                                    dividerThickness: 1,
                                    columns: const [
                                      DataColumn(
                                          label: Text("Test Post-Esercitazione")),
                                      DataColumn(label: Text("Risultato")),
                                      DataColumn(label: Text('Tempo medio di reazione')),
                                      DataColumn(label: Text('Movimento del mouse')),
                                      DataColumn(label: Text('Metodo di interazione'))
                                    ],
                                    rows: vm.testPost.map((test) {
                                      return DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              test.nomeTest,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          DataCell(Text("${test.domandeCorrette} / ${test.totaleDomande}")),
                                          DataCell(Text("${test.tempoMedioReazione.toStringAsFixed(2)} ms"),),
                                          DataCell(Text('${test.movimentoMouse}')),
                                        //const DataCell(Text('Metodo interazione'))
                                      ]);
                                    }).toList(),
                                    border: TableBorder.symmetric(
                                      inside: const BorderSide(
                                          color: Colors.black, width: 1),
                                      outside: const BorderSide(
                                          color: Colors.black, width: 1),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 32),

                              Column(
                                children: [
                                  /// 📈 GRAFICO TEST PRE
                                  if (vm.progressiPreChartData.isNotEmpty)
                                    LineChartWidget(
                                      data: vm.progressiPreChartData,
                                      title: 'Andamento Test Pre',
                                      xAxisTitle: 'Test Pre',
                                      yAxisTitle: 'Punteggio',
                                      maxY: vm.maxPreY,
                                    ),

                                    /// 📈 GRAFICO TEST POST
                                    if (vm.progressiPostChartData.isNotEmpty)
                                      LineChartWidget(
                                        data: vm.progressiPostChartData,
                                        title: 'Andamento Test Post',
                                        xAxisTitle: 'Test Post',
                                        yAxisTitle: 'Punteggio',
                                        maxY: vm.maxPostY,
                                      ),
                                ],
                              ),

                              /// 📌 SEZIONE DIAGNOSI
                              const SizedBox(height: 32),
                              Consumer<DashboardBambinoViewModel>(
                                builder: (context, vm, _) {
                                  final diagnosi = vm.bambino.diagnosi;
                                  if (diagnosi == null) {                  // Stato: nessuna diagnosi
                                    return Center(
                                      child: ElevatedButton.icon(
                                        icon: const Icon(Icons.add),
                                        label: const Text("Inserisci Diagnosi"),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: () async {
                                          final nuovaDiagnosi = await showDialog<Diagnosi>(
                                            context: context,
                                            builder: (_) => DiagnosiDialog(),
                                          );
                                          if (nuovaDiagnosi != null) {
                                            await vm.inserisciDiagnosi(nuovaDiagnosi);
                                          }
                                        },
                                      ),
                                    );
                                  } else {                                 // Stato: diagnosi presente
                                      return Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black, width: 2),
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Diagnosi",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            Text(
                                              diagnosi.testo,
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "Gravità: ${diagnosi.livelloGravita.name}",
                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                            ),
                                            if (diagnosi.note != null && diagnosi.note!.isNotEmpty)
                                              Padding(
                                                padding: const EdgeInsets.only(top: 4.0),
                                                child: Text(
                                                  "Note: ${diagnosi.note}",
                                                  style: const TextStyle(fontSize: 14),
                                                ),
                                              ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "Inserita il: ${_formatDate(diagnosi.dataInserimento)}",
                                              style: const TextStyle(fontSize: 12, color: Colors.white),
                                            ),
                                            const SizedBox(height: 12),
                                            Row(
                                              children: [
                                                ElevatedButton.icon(
                                                  icon: const Icon(Icons.edit),
                                                  label: const Text("Modifica"),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.black,
                                                    foregroundColor: Colors.white
                                                  ),
                                                  onPressed: () async {
                                                    final modificata = await showDialog<Diagnosi>(
                                                      context: context,
                                                      builder: (_) => DiagnosiDialog(diagnosi: diagnosi),
                                                    );
                                                    if (modificata != null) {
                                                      await vm.modificaDiagnosi(modificata);
                                                    }
                                                  },
                                                ),
                                                const SizedBox(width: 12),
                                                ElevatedButton.icon(
                                                  icon: const Icon(Icons.delete),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.black,
                                                    foregroundColor: Colors.white,
                                                  ),
                                                  label: const Text("Elimina"),
                                                  onPressed: () async {
                                                    final conferma = await showDialog<bool>(
                                                      context: context,
                                                      builder: (_) => AlertDialog(
                                                        title: const Text("Conferma eliminazione"),
                                                        content: const Text("Sei sicuro di voler eliminare la diagnosi?"),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () => Navigator.pop(context, false),
                                                            child: const Text("Annulla"),
                                                          ),
                                                          TextButton(
                                                            onPressed: () => Navigator.pop(context, true),
                                                            child: const Text("Elimina"),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                    if (conferma == true) {
                                                      await vm.eliminaDiagnosi();
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(height: 32),
                                const SizedBox(height: 32),
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
