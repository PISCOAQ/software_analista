import 'package:flutter/material.dart';
import 'package:software_analista/domain/models/bambino.dart';
import 'package:software_analista/domain/models/sesso.dart';
import 'package:software_analista/ui/screens/dashboard_bambinoScreen.dart';
import 'package:software_analista/ui/screens/lista_percorsiScreen.dart';
import 'package:software_analista/ui/screens/registrazione_bambinoScreen.dart';
import 'package:software_analista/ui/viewmodels/lista_bambiniViewmodel.dart';
import 'package:provider/provider.dart';
import 'package:software_analista/ui/widgets/tab_button.dart';

class Lista_bambiniScreen extends StatefulWidget {
  const Lista_bambiniScreen({super.key});

  @override
  State<Lista_bambiniScreen> createState() => _Lista_bambiniScreenState();
}

class _Lista_bambiniScreenState extends State<Lista_bambiniScreen> {
  int selectedTab = 0; // 0 = Lista Bambini, 1 = Lista Percorsi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("I bambini seguiti"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: "Aggiungi bambino",
            onPressed: () async {
              // Naviga allo screen di registrazione
              final nuovoBambino = await Navigator.push(
                context,
                MaterialPageRoute(
                builder: (_) => const RegistrazioneBambinoScreen(),
              ),
              );
              // Se viene creato un nuovo bambino, aggiorna la lista
              if (nuovoBambino != null) {
                final vm = context.read<lista_bambiniViewmodel>();
                vm.aggiungiBambino(nuovoBambino); // metodo da implementare nel ViewModel
              }
            },
          ),
        ],
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),

          // 🔵🔘 BARRA DI SWITCH
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              tab_button(
                label: "Lista Bambini",
                isSelected: selectedTab == 0,
                onTap: () {
                  setState(() => selectedTab = 0);
                  // sei già su questa pagina
                },
              ),
              const SizedBox(width: 12),
              tab_button(
                label: "Lista Percorsi",
                isSelected: selectedTab == 1,
                onTap: () {
                  setState(() => selectedTab = 1);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Lista_percorsiScreen(),
                    ),
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 20),

          // 🔄 LISTA BAMBINI
          Expanded(
            child: Consumer<lista_bambiniViewmodel>(
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
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                Dashboard_bambinoScreen(bambino: bambino),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: bambino.sesso == Sesso.maschio
                                    ? Colors.blue.shade200
                                    : Colors.pink.shade200,
                                child: Icon(
                                  bambino.sesso == Sesso.maschio
                                      ? Icons.boy
                                      : Icons.girl,
                                  size: 36,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${bambino.nome} ${bambino.cognome}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "Età: ${_calcolaEta(bambino.dataDiNascita)} anni",
                                      style: TextStyle(
                                          color: Colors.grey.shade700),
                                    )
                                  ],
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios, size: 18),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  int _calcolaEta(DateTime dataNascita) {
    final now = DateTime.now();
    int anni = now.year - dataNascita.year;
    if (now.month < dataNascita.month ||
        (now.month == dataNascita.month && now.day < dataNascita.day)) {
      anni--;
    }
    return anni;
  }
}

