import 'package:trivelaapp/repository/home_repository.dart';
import 'package:trivelaapp/response/saldo_response.dart';

class HomePageController {
  final HomeRepository _repository;

  HomePageController(this._repository);

  Future<SaldoResponse> getSaldo() async {
    SaldoResponse responseSaldo;
    try {
      responseSaldo = await _repository.getSaldoReal();
    } catch (e) {}

    return responseSaldo;
  }

  Future<SaldoResponse> getSaldoBonus() async {
    SaldoResponse responseSaldo;
    try {
      responseSaldo = await _repository.getSaldoBonus();
    } catch (e) {}

    return responseSaldo;
  }

  Future<String> getImage() async {
    return await _repository.getImage();
  }
}
