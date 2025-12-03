import 'package:flutter/material.dart';
import 'package:software_analista/domain/models/bambino.dart';
import 'package:software_analista/domain/models/sesso.dart';
import 'package:software_analista/ui/screens/dashboard_bambinoScreen.dart';
import 'package:software_analista/ui/viewmodels/lista_bambiniViewmodel.dart';
import 'package:provider/provider.dart';



class Lista_bambiniScreen extends StatelessWidget {
  const Lista_bambiniScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("I bambini seguiti"),
        centerTitle: true,
      ),

      body: Consumer<lista_bambiniViewmodel>(
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
              return _BambinoCard(bambino: bambino);
            },
          );
        },
      ),
    );
  }
}

class _BambinoCard extends StatelessWidget {
  final Bambino bambino;

  const _BambinoCard({required this.bambino});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Dashboard_bambinoScreen(bambino: bambino),
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
              _buildAvatar(),
              const SizedBox(width: 16),

              // Nome, cognome, età
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
                        color: Colors.grey.shade700,
                      ),
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
  }

  Widget _buildAvatar() {
    final isMaschio = bambino.sesso == Sesso.maschio;

    return CircleAvatar(
      radius: 28,
      backgroundColor: isMaschio ? Colors.blue.shade200 : Colors.pink.shade200,
      child: Icon(
        isMaschio ? Icons.boy : Icons.girl,
        size: 36,
        color: Colors.white,
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
