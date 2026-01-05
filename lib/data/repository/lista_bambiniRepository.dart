import 'package:software_analista/data/service/lista_bambiniService.dart';
import 'package:software_analista/domain/models/bambino.dart';

class ListaBambiniRepository {
  final ListaBambiniService service;

  ListaBambiniRepository(this.service);

  Future<List<Bambino>> listaBambini() {
    return service.listaBambini();
  }
}
