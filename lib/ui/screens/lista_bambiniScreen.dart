import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_analista/ui/screens/dashboard_bambinoScreen.dart';
import 'package:software_analista/ui/screens/registrazione_bambinoScreen.dart';
import 'package:software_analista/ui/viewmodels/lista_bambiniViewmodel.dart';
import 'package:software_analista/ui/widgets/BambinoCard.dart';
import 'package:software_analista/ui/widgets/Sidebar.dart';
import 'package:software_analista/ui/widgets/Topbar.dart';

class Lista_bambiniScreen extends StatefulWidget {
  const Lista_bambiniScreen({super.key});

  @override
  State<Lista_bambiniScreen> createState() => _Lista_bambiniScreenState();
}

class _Lista_bambiniScreenState extends State<Lista_bambiniScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Row(
        children: [
          // Sidebar
          Sidebar(),

          // Contenuto principale
          Expanded(
            child: Column(
              children: [
                // TopBar
                TopBar(),

                // Titolo della pagina
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Text(
                    "Lista Bambini",
                    style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                    ),
                  ),
                ),

                // Azioni di pagina (sotto la topbar)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.person_add),
                        label: const Text("Aggiungi bambino"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () async {
                          final nuovoBambino = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const RegistrazioneBambinoScreen(),
                            ),
                          );

                          if (nuovoBambino != null) {
                            final vm =
                                context.read<lista_bambiniViewmodel>();
                            vm.aggiungiBambino(nuovoBambino);
                          }
                        },
                      ),
                    ],
                  ),
                ),

                // Contenuto della pagina
                Expanded(
                  child: _buildContenuto(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContenuto() {
    return Consumer<lista_bambiniViewmodel>(
      builder: (context, vm, _) {
        if (vm.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (vm.bambini.isEmpty) {
          return const Center(
            child: Text(
              "Nessun bambino presente",
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: vm.bambini.length,
          itemBuilder: (context, index) {
            final bambino = vm.bambini[index];
            return BambinoCard(
              bambino: bambino,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Dashboard_bambinoScreen(bambino: bambino),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
