import 'package:flutter/material.dart';
import 'package:software_analista/domain/models/bambino.dart';
import 'package:software_analista/domain/models/percorso.dart';
import 'package:software_analista/ui/widgets/BambinoCard.dart';
import 'package:software_analista/ui/widgets/Sidebar.dart';
import 'package:software_analista/ui/widgets/Topbar.dart';
import 'package:software_analista/ui/widgets/percorso_card.dart';

class AssegnazioneRiassuntoScreen extends StatelessWidget {
  final Bambino bambino;
  final Percorso percorso;

  const AssegnazioneRiassuntoScreen({
    super.key,
    required this.bambino,
    required this.percorso,
  });

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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: BambinoCard(bambino: bambino)),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(Icons.arrow_forward, size: 32, color: Colors.blue),
                      ),
                      Expanded(child: percorso_card(percorso: percorso)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // qui chiami il metodo per salvare l'assegnazione sul DB
                    },
                    child: const Text('Conferma Assegnazione'),
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
