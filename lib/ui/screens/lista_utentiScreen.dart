import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_analista/data/service/dashboard_utenteService.dart';
import 'package:software_analista/domain/models/utente.dart';
import 'package:software_analista/ui/screens/dashboard_utenteScreen.dart';
import 'package:software_analista/ui/screens/registrazione_utenteScreen.dart';
import 'package:software_analista/ui/viewmodels/lista_utentiViewmodel.dart';
import 'package:software_analista/ui/widgets/UtenteCard.dart';
import 'package:software_analista/ui/widgets/Sidebar.dart';
import 'package:software_analista/ui/widgets/Topbar.dart';
import 'package:software_analista/data/repository/dashboard_utenteRepository.dart';

class Lista_utentiScreen extends StatefulWidget {
  const Lista_utentiScreen({super.key});

  @override
  State<Lista_utentiScreen> createState() => _Lista_utentiScreenState();
}

class _Lista_utentiScreenState extends State<Lista_utentiScreen> {
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
                          final nuovoUtente = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const RegistrazioneUtenteScreen(),
                            ),
                          );

                          if (nuovoUtente != null) {
                            final vm =
                                context.read<lista_utentiViewmodel>();
                            vm.aggiungiUtente(nuovoUtente);
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
    return Consumer<lista_utentiViewmodel>(
      builder: (context, vm, _) {
        if (vm.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (vm.utenti.isEmpty) {
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
              itemCount: vm.utenti.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final utente = vm.utenti[index];

                return UtenteCard(
                  utente: utente,
                  onTap: () {
                    final testService = Dashboard_utenteService();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            Dashboard_utenteScreen(utente: utente, repository: DashboardUtenterepository(testService),),
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
