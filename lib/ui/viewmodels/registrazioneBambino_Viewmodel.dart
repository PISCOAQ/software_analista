import 'package:flutter/material.dart';
import 'package:software_analista/data/repository/registrazione_bambiniRepository.dart';
import 'package:software_analista/data/service/registrazione_bambiniService.dart';
import 'package:software_analista/domain/models/bambino.dart';
import 'package:software_analista/domain/models/percorso.dart';
import 'package:software_analista/domain/models/sesso.dart';
import 'package:uuid/uuid.dart';

class Registrazionebambino_Viewmodel extends ChangeNotifier{
  String nome = '';
  String cognome = '';
  DateTime? dataNascita;
  Sesso sesso = Sesso.maschio;
  Percorso? percorso;
  bool isLoading = true;
  String? errorMessage;
  final RegistrazioneBambinoRepository repository;

  Registrazionebambino_Viewmodel({required this.repository}){
    _initForm();
  }

    Future<void> _initForm() async{
    await Future.delayed(const Duration(milliseconds: 300)); // Simula caricamento
    isLoading = false;
    nome = '';
    cognome = '';
    sesso = Sesso.maschio;
    dataNascita = null;
    errorMessage = null;

    notifyListeners();
  }

  void updateNome( String value){
    nome = value;
    notifyListeners();
  }
  void updateCognome (String value){
    cognome = value;
    notifyListeners();
  }
  void updateDataNascita(DateTime value){
    dataNascita = value;
    notifyListeners();
  }
  void updateSesso(Sesso? value){
    sesso = value!;
    notifyListeners();
  }


  Future<Bambino?> registraBambino() async {
    if (nome.isEmpty || cognome.isEmpty || dataNascita == null) {
    errorMessage = 'Compila tutti i campi obbligatori';
    notifyListeners();
    return null;
    }
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      final bambino = Bambino(
        nome: nome,
        cognome: cognome,
        dataDiNascita: dataNascita!,
        sesso: sesso!,
      );

      final bambinoCreato = await repository.creaBambino(bambino);
      return bambinoCreato; // contiene anche l'ID generato dal backend
    } catch (e) {
      errorMessage = 'Errore durante la registrazione: $e';
      notifyListeners();
      return null;
    } finally{
      isLoading = false;
      notifyListeners();
    }
  }
}