import 'package:flutter/material.dart';
import 'package:software_analista/domain/models/bambino.dart';
import 'package:software_analista/domain/enums/sesso.dart';

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
      elevation: 1.5,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: Colors.black.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              // Cerchio iconico del sesso
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: bambino.sesso == Sesso.maschio
                      ? Colors.blue.shade300
                      : Colors.pink.shade300,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  bambino.sesso == Sesso.maschio ? Icons.boy : Icons.girl,
                  size: 26,
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Età: ${_calcolaEta(bambino.dataDiNascita)} anni",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                size: 26,
                color: Colors.black,
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
