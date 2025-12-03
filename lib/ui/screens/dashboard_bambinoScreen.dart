import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_analista/domain/models/bambino.dart';
import 'package:software_analista/ui/viewmodels/dashboard_bambinoViewmodel.dart';


class Dashboard_bambinoScreen extends StatelessWidget {
  final Bambino bambino;

  const Dashboard_bambinoScreen({super.key, required this.bambino});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final vm = dashboard_bambinoViewmodel(bambino: bambino);
        vm.loadBambino(bambino); // <-- carichiamo i dati finti
        return vm;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Dashboard di ${bambino.nome}"),
          centerTitle: true,
        ),
        body: Consumer<dashboard_bambinoViewmodel>(
          builder: (context, vm, _) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (vm.bambino == null) {
              return const Center(child: Text("Dati non disponibili"));
            }

            final b = vm.bambino!;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // ------------------------
                  //   CARD PROFILO BAMBINO
                  // ------------------------
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.blue.shade100,
                            child: const Icon(Icons.person, size: 45),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  b.nome,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Data di nascita: ${b.dataDiNascita} ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade700),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ------------------------
                  //   CARD STATO GENERALE
                  // ------------------------
                  /*Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Stato attuale",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          //_buildInfoRow("Ultima valutazione:", b.ultimaValutazione),
                          //_buildInfoRow("Livello attuale:", b.livello),
                          //_buildInfoRow("Note generali:", b.note),
                        ],
                      ),
                    ),
                  ),*/

                  const SizedBox(height: 20),

                  // ------------------------
                  //   PULSANTI / SEZIONI
                  // ------------------------
                  Column(
                    children: [
                      _buildActionButton(Icons.analytics, "Valutazioni"),
                      const SizedBox(height: 10),
                      _buildActionButton(Icons.description, "Report e documenti"),
                      const SizedBox(height: 10),
                      _buildActionButton(Icons.school, "Percorso educativo"),
                      const SizedBox(height: 10),
                      _buildActionButton(Icons.list_alt, "Questionari"),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ------------------------
  //  WIDGET DI SUPPORTO
  // ------------------------
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String text) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.blue.shade50,
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: Colors.blue),
            const SizedBox(width: 16),
            Text(
              text,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 20),
          ],
        ),
      ),
    );
  }
}
