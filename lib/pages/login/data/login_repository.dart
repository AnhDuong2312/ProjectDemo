import 'dart:convert';

import '../domain/adapter/login_adapter.dart';
import 'login_provider.dart';
import 'package:crypto/crypto.dart';

class LoginRepository implements ILoginRepository {
  final ILoginProvider provider;

  LoginRepository({required this.provider});

  @override
  Future<dynamic> login(
      String taxCode, String userName, String password) async {
    var bytes = utf8.encode(password);
    var passwordHash = sha256.convert(bytes).toString();
    final params = {
      "taxCode": taxCode,
      "password": passwordHash,
      "companyUsername": userName,
    };

    final response = await provider.login('sign-in', params);
    return response;
  }
}
