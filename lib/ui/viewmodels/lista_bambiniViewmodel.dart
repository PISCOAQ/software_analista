import 'package:flutter/material.dart';
import 'package:software_analista/domain/models/bambino.dart';
import 'package:software_analista/data/service/lista_bambiniService.dart';
import 'package:software_analista/data/repository/lista_bambiniRepository.dart';

class lista_bambiniViewmodel extends ChangeNotifier{
  final ListaBambiniRepository _repository = ListaBambiniRepository(ListaBambiniService());
  List<Bambino> _bambini = [];
  bool _isLoading = true;

  List<Bambino> get bambini => _bambini;
  bool get isLoading => _isLoading;

  lista_bambiniViewmodel(){
    loadBambini();
  }

  Future<void> loadBambini() async{
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));
    _bambini = await _repository.listaBambini();
    _isLoading = false;
    notifyListeners();
  }

  // Aggiunge un nuovo bambino (opzionale)
  void aggiungiBambino(Bambino nuovoBambino) {
    _bambini.add(nuovoBambino);
    notifyListeners();
  }

  // Aggiorna un bambino esistente (opzionale)
  void aggiornaBambino(Bambino bambinoAggiornato) {
    final index = _bambini.indexWhere((b) => b.id == bambinoAggiornato.id);
    if (index != -1) {
      _bambini[index] = bambinoAggiornato;
      notifyListeners();
    }
  }

  int calcolaEta(DateTime dataNascita) {
    final now = DateTime.now();
    int anni = now.year - dataNascita.year;
    if (now.month < dataNascita.month ||
        (now.month == dataNascita.month && now.day < dataNascita.day)) {
      anni--;
    }
    return anni;
  }
}