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

                /// TITOLO
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  child: Text(
                    "Elenco Utenti",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                /// AZIONI (BOTTONE)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(
                          Icons.person_add,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Aggiungi utente",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
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

                /// CONTENUTO LISTA
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (vm.bambini.isEmpty) {
          return const Center(
            child: Text(
              "Nessun utente presente",
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        /// 🔥 LISTA CENTRATA E NON A TUTTA LARGHEZZA
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600, // ⬅️ qui regoli la larghezza delle card
            ),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: vm.bambini.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final bambino = vm.bambini[index];

                return BambinoCard(
                  bambino: bambino,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            Dashboard_bambinoScreen(bambino: bambino),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
