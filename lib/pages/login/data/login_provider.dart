import 'package:get/get_connect/connect.dart';
import 'package:icorp_print_ticket/common/mixins/server_config_mixin.dart';

import '../../../common/api/api_service.dart';
import 'package:http/http.dart' as http;
import '../../../common/api/request.dart';

abstract class ILoginProvider {
  Future<dynamic> login(String path, dynamic query);
}

class LoginProvider extends GetConnect
    implements ILoginProvider {
  final ApiService apiService = ApiService(http.Client());

  @override
  Future<dynamic> login(String path, dynamic params) =>  apiService.send(Request(path, RequestMethod.post, params));
}
