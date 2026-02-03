import 'package:flutter/material.dart';
import 'package:software_analista/data/repository/lista_bambiniRepository.dart';
import 'package:software_analista/data/service/lista_bambiniService.dart';
import 'package:software_analista/domain/models/bambino.dart';
import 'package:software_analista/domain/enums/sesso.dart';

class HomeViewModel extends ChangeNotifier {
  final ListaBambiniRepository _bambiniRepository = ListaBambiniRepository(ListaBambiniService());

  bool isLoading = false;

  int numeroBambini = 0;
  int numeroMaschi = 0;
  int numeroFemmine = 0;
  int numeroPercorsi = 0;

  HomeViewModel() {
    caricaDati();
  }

  Future<void> caricaDati() async {
    isLoading = true;
    notifyListeners();

    try {
      // Recupero lista completa dei bambini
      final List<Bambino> bambini = await _bambiniRepository.listaBambini();

      // Calcolo dati per la home
      numeroBambini = bambini.length;
      numeroMaschi = bambini.where((b) => b.sesso == Sesso.maschio).length;
      numeroFemmine = bambini.where((b) => b.sesso == Sesso.femmina).length;

      // Recupero numero percorsi da definire

    } catch (e) {
      // gestione errori
      numeroBambini = 0;
      numeroMaschi = 0;
      numeroFemmine = 0;
      numeroPercorsi = 0;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
