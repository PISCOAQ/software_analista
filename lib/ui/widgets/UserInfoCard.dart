import 'package:flutter/material.dart';
import 'package:software_analista/domain/enums/extensions_scuola.dart';
import 'package:software_analista/domain/enums/extensions_titoloStudio.dart';
import 'package:software_analista/domain/models/utente.dart';
import 'package:software_analista/ui/widgets/InfoItem.dart';
import 'package:software_analista/ui/widgets/codiceutenteRow.dart';
import 'package:software_analista/utils/formatDate.dart';
import 'package:software_analista/utils/formatSesso.dart';

class UserInfoCard extends StatelessWidget {
  final Utente utente;

  const UserInfoCard({super.key, required this.utente});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Dati utente",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              InfoItem(
                label: "Data di nascita",
                value: FormatDate(utente.dataDiNascita),
              ),
              InfoItem(label: "Sesso", value: FormatSesso(utente.sesso)),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              InfoItem(
                label: "Scuola Frequentata",
                value: utente.scuolaFrequentata.label,
              ),
              InfoItem(
                label: "Titolo di studio",
                value: utente.titoloStudio.label,
              ),
            ],
          ),

          const SizedBox(height: 12),

          CodiceUtenteRow(codice: utente.codiceGioco),
        ],
      ),
    );
  }
}
