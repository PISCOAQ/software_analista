import 'package:flutter/material.dart';
import 'package:software_analista/domain/models/percorso.dart';

class percorso_card extends StatelessWidget {
  final Percorso percorso;
  final VoidCallback? onTap; 

  const percorso_card({
    super.key,
    required this.percorso,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          percorso.nome,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Nodi: ${percorso.numNodi}"),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }
}
