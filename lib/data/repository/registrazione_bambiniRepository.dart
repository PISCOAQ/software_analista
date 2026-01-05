import 'package:software_analista/data/service/registrazione_bambiniService.dart';
import 'package:software_analista/domain/models/bambino.dart';

class RegistrazioneBambinoRepository {
  final RegistrazioneBambinoService service;

  RegistrazioneBambinoRepository(this.service);

  Future<void> creaBambino(Bambino bambino) {
    return service.creaBambino(bambino);
  }
}