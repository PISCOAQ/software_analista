import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_analista/data/repository/registrazione_bambiniRepository.dart';
import 'package:software_analista/data/service/registrazione_bambiniService.dart';
import 'package:software_analista/domain/models/bambino.dart';
import 'package:software_analista/ui/screens/lista_bambiniScreen.dart';
import 'package:software_analista/ui/viewmodels/registrazioneBambino_Viewmodel.dart';
import 'package:software_analista/domain/models/sesso.dart';
import 'package:software_analista/ui/widgets/Sidebar.dart';
import 'package:software_analista/ui/widgets/Topbar.dart';
import 'package:flutter/services.dart';

class RegistrazioneBambinoScreen extends StatelessWidget {
  const RegistrazioneBambinoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Registrazionebambino_Viewmodel(
        repository: RegistrazioneBambinoRepository(
          service: RegistrazioneBambinoService(),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Row(
          children: [
            Sidebar(),

            // Contenuto principale
            Expanded(
              child: Column(
                children: [
                  TopBar(),

                  // Titolo della pagina
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    child: Text(
                      "Registrazione nuovo bambino",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),

                  // Contenuto centrale
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Consumer<Registrazionebambino_Viewmodel>(
                        builder: (context, vm, _) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                decoration: const InputDecoration(
                                  labelText: 'Nome',
                                ),
                                onChanged: vm.updateNome,
                              ),
                              const SizedBox(height: 12),

                              TextField(
                                decoration: const InputDecoration(
                                  labelText: 'Cognome',
                                ),
                                onChanged: vm.updateCognome,
                              ),
                              const SizedBox(height: 12),

                              DropdownButtonFormField<Sesso>(
                                decoration: const InputDecoration(
                                  labelText: 'Sesso',
                                ),
                                value: vm.sesso,
                                items: Sesso.values.map((s) {
                                  return DropdownMenuItem(
                                    value: s,
                                    child: Text(s.name),
                                  );
                                }).toList(),
                                onChanged: vm.updateSesso,
                              ),
                              const SizedBox(height: 24),

                              /// 📅 DATA DI NASCITA
                              InkWell(
                                onTap: () async {
                                  final pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        vm.dataNascita ?? DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now(),
                                  );

                                  if (pickedDate != null) {
                                    vm.updateDataNascita(pickedDate);
                                  }
                                },
                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                    labelText: 'Data di nascita',
                                    border: OutlineInputBorder(),
                                  ),
                                  child: Text(
                                    vm.dataNascita != null
                                        ? '${vm.dataNascita!.day}/${vm.dataNascita!.month}/${vm.dataNascita!.year}'
                                        : 'Seleziona una data',
                                    style: TextStyle(
                                      color: vm.dataNascita != null
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),

                              /// 🔴 Messaggio di errore
                              if (vm.errorMessage != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Text(
                                    vm.errorMessage!,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final nuovoBambino = await vm.registraBambino();
                                    if (nuovoBambino != null) {
                                      final bambinoDaRitornare = await _showSuccessDialog(context, nuovoBambino);
                                      Navigator.pop(context, bambinoDaRitornare);
                                    }
                                  },
                                  child: const Text('Registra'),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
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

  Future <Bambino?> _showSuccessDialog(BuildContext context, Bambino bambino) {
    return showDialog<Bambino>( 
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Registrazione completata 🎉'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Codice gioco:'),
            const SizedBox(height: 8),
            SelectableText(
              bambino.codiceGioco!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Clipboard.setData(
                ClipboardData(text: bambino.codiceGioco!),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Codice copiato negli appunti')),
              );
            },
            icon: const Icon(Icons.copy),
            label: const Text('Copia Codice'),
          ),
          ElevatedButton(
            onPressed: () {
              debugPrint('CHIUDO DIALOG E RITORNO BAMBINO');
              Navigator.of(context, rootNavigator: true).pop(bambino);
            },
            child: const Text('Chiudi'),
          ),
        ],
      ),
    );
  }
}
