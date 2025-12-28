import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_analista/ui/viewmodels/registrazioneBambino_Viewmodel.dart';
import 'package:software_analista/domain/models/sesso.dart';

class RegistrazioneBambinoScreen extends StatelessWidget {
  const RegistrazioneBambinoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Registrazionebambino_Viewmodel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registrazione nuovo bambino'),
        ),
        body: Consumer<Registrazionebambino_Viewmodel>(
          builder: (context, vm, _) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
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
                  // 🔴 Messaggio di errore
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
                      onPressed: () {
                              final nuovoBambino =  vm.creaBambino();
                              if (nuovoBambino != null) {
                                Navigator.pop(context, nuovoBambino);
                              }
                            },
                      child: const Text('Registra'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
