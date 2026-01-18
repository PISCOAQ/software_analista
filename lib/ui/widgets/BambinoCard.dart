import 'package:flutter/material.dart';
import 'package:software_analista/domain/models/bambino.dart';
import 'package:software_analista/domain/models/sesso.dart';

class BambinoCard extends StatelessWidget {
  final Bambino bambino;
  final VoidCallback? onTap;

  const BambinoCard({
    super.key,
    required this.bambino,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.blue.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              // Cerchio iconico del sesso
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: bambino.sesso == Sesso.maschio
                      ? Colors.blue.shade300
                      : Colors.pink.shade300,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  bambino.sesso == Sesso.maschio ? Icons.boy : Icons.girl,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              // Info bambino
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${bambino.nome} ${bambino.cognome}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Età: ${_calcolaEta(bambino.dataDiNascita)} anni",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Colors.grey,
              ),
            ],
          ),
        ),
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
