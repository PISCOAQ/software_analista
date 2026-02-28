import 'package:flutter/material.dart';
import 'package:software_analista/domain/models/utente.dart';
import 'package:software_analista/data/service/lista_utentiService.dart';
import 'package:software_analista/data/repository/lista_utentiRepository.dart';

class lista_utentiViewmodel extends ChangeNotifier{
  final ListaUtentiRepository _repository = ListaUtentiRepository(ListaUtentiService());
  List<Utente> _utenti = [];
  bool _isLoading = true;

  List<Utente> get utenti => _utenti;
  bool get isLoading => _isLoading;

  lista_utentiViewmodel(){
    loadUtenti();
  }

  Future<void> loadUtenti() async{
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));
    _utenti = await _repository.listaUtenti();
    _isLoading = false;
    notifyListeners();
  }

  // Aggiunge un nuovo utente (opzionale)
  void aggiungiUtente(Utente nuovoUtente) {
    _utenti.add(nuovoUtente);
    notifyListeners();
  }

  // Aggiorna un utente esistente (opzionale)
  void aggiornaUtente(Utente utenteAggiornato) {
    final index = _utenti.indexWhere((b) => b.id == utenteAggiornato.id);
    if (index != -1) {
      _utenti[index] = utenteAggiornato;
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