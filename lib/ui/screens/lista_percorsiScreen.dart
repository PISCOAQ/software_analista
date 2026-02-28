import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_analista/ui/viewmodels/lista_percorsiViewmodel.dart';
import 'package:software_analista/ui/widgets/Sidebar.dart';
import 'package:software_analista/ui/widgets/Topbar.dart';
import 'package:software_analista/ui/widgets/percorso_card.dart';

class Lista_percorsiScreen extends StatefulWidget {
  const Lista_percorsiScreen({super.key});

  @override
  State<Lista_percorsiScreen> createState() => _Lista_percorsiScreenState();
}

class _Lista_percorsiScreenState extends State<Lista_percorsiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // Sidebar
          Sidebar(),

          // Contenuto principale
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TopBar
                TopBar(),

                // Titolo della pagina
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 600,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: Text(
                        "Percorsi disponibili",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),

                // Contenuto della pagina (lista percorsi)
                Expanded(
                  child: Consumer<lista_percorsiViewModel>(
                    builder: (context, vm, _) {
                      if (vm.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (vm.percorsi.isEmpty) {
                        return const Center(
                          child: Text(
                            "Nessun percorso registrato",
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      }

                      return Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 600,
                          ),
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            itemCount: vm.percorsi.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final percorso = vm.percorsi[index];
                              return percorso_card(
                                percorso: percorso,
                                onTap: () {},
                              );
                            },
                          ),
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
    );
  }
}
