import 'package:software_analista/data/service/dashboard_bambinoService.dart';
import 'package:software_analista/domain/models/risultatoTest.dart';

class DashboardBambinorepository {
  final Dashboard_bambinoService service;

  DashboardBambinorepository(this.service);

  Future<List<Test>> getTestByBambino(String? codiceGioco){
    return service.getTestByBambino(codiceGioco);
  }


}