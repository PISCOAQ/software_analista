import 'package:software_analista/data/service/assegna_percorsoService.dart';
import 'package:software_analista/domain/models/bambino.dart';

class AssegnaPercorsoRepository {
  final AssegnaPercorsoService service;

  AssegnaPercorsoRepository(this.service);

  Future<Bambino> assegnaPercorso(String? bambinoId, String percorsoIdEsterno, String nomePercorso ) {
    return service.assegnaPercorso(bambinoId: bambinoId, percorsoIdEsterno: percorsoIdEsterno, nomePercorso: nomePercorso);
  }
}