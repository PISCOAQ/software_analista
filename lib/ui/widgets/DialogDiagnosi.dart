import 'package:flutter/material.dart';
import 'package:software_analista/domain/enums/livelloGravita.dart';
import 'package:software_analista/domain/models/diagnosi.dart';

class DiagnosiDialog extends StatefulWidget {
  final Diagnosi? diagnosi;

  const DiagnosiDialog({super.key, this.diagnosi});

  @override
  State<DiagnosiDialog> createState() => _InserisciDiagnosiDialogState();
}

class _InserisciDiagnosiDialogState extends State<DiagnosiDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _testoController;
  late TextEditingController _noteController;
  LivelloGravita? _livelloSelezionato;

  @override
  void initState() {
    super.initState();
    _testoController = TextEditingController(text: widget.diagnosi?.testo ?? "");
    _noteController = TextEditingController(text: widget.diagnosi?.note ?? "");
    _livelloSelezionato = widget.diagnosi?.livelloGravita;
  }

  @override
  void dispose() {
    _testoController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.diagnosi == null ? "Nuova Diagnosi" : "Modifica Diagnosi"),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _testoController,
                decoration: const InputDecoration(labelText: "Testo Diagnosi"),
                maxLines: 4,
                validator: (val) => val == null || val.isEmpty ? "Campo obbligatorio" : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<LivelloGravita>(
                value: _livelloSelezionato,
                decoration: const InputDecoration(labelText: "Livello Gravità"),
                items: LivelloGravita.values
                    .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                    .toList(),
                onChanged: (val) => setState(() => _livelloSelezionato = val),
                validator: (val) => val == null ? "Seleziona un livello" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(labelText: "Note aggiuntive (opzionale)"),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Annulla"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final nuova = Diagnosi(
                testo: _testoController.text,
                livelloGravita: _livelloSelezionato!,
                note: _noteController.text.isEmpty ? null : _noteController.text,
                dataInserimento: widget.diagnosi?.dataInserimento ?? DateTime.now(),
              );
              Navigator.pop(context, nuova);
            }
          },
          child: const Text("Salva"),
        ),
      ],
    );
  }
}
