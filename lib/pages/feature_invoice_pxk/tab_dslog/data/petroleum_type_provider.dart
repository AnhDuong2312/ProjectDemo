import '../../../../common/api/api_service.dart';
import '../../../../common/api/request.dart';
import 'package:http/http.dart' as http;

abstract class IPetroleumTypeProvider {
  Future<dynamic> getProducts(String path, dynamic params);
}

class PetroleumTypeProvider implements IPetroleumTypeProvider {
  final ApiService apiService = ApiService(http.Client());

  @override
  Future<dynamic> getProducts(String path, dynamic params) =>
      apiService.send(Request(path, RequestMethod.get, params));
}
