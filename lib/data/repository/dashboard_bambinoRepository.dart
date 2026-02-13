import 'package:software_analista/data/service/dashboard_bambinoService.dart';
import 'package:software_analista/domain/models/bambino.dart';
import 'package:software_analista/domain/models/diagnosi.dart';
import 'package:software_analista/domain/models/risultatoTest.dart';

class DashboardBambinorepository {
  final Dashboard_bambinoService service;

  DashboardBambinorepository(this.service);

  Future<List<Test>> getTestByBambino(String? codiceGioco){
    return service.getTestByBambino(codiceGioco);
  }

  Future<Bambino> salvaDiagnosi(String? bambinoId, Diagnosi diagnosi){
    return service.salvaDiagnosi(bambinoId, diagnosi);
  }

  Future<Bambino> eliminaDiagnosi(String? bambinoId){
    return service.eliminaDiagnosi(bambinoId);
  }

  Future<String> downloadExcel(String bambinoId, String nomeBambino) async {
    return service.downloadExcel(bambinoId, nomeBambino);
  }
}