import 'package:trivelaapp/repository/campeonato_repository.dart';
import 'package:trivelaapp/response/campeonato_response.dart';

class CampeonatoController {
  Future<CampeonatoResponse> getCampeonatos() async {
    final CampeonatoRepository repository = CampeonatoRepository();
    CampeonatoResponse campeonatoResponse;
    try {
      campeonatoResponse = await repository.getCampeonatos();
    } catch (e) {}
    return campeonatoResponse;
  }
}
