import 'package:trivelaapp/repository/home_repository.dart';
import 'package:trivelaapp/response/saldo_response.dart';

class HomePageController {
  Future<SaldoResponse> getSaldo() async {
    final HomeRepository repository = HomeRepository();
    SaldoResponse responseSaldo;
    try {
      responseSaldo = await repository.getSaldoReal();
    } catch (e) {}

    return responseSaldo;
  }
}
