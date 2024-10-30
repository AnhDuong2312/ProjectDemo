import 'package:icorp_print_ticket/common/api/request.dart';
import '../../../../common/api/api_service.dart';


import 'package:http/http.dart' as http;

abstract class ISeriesProvider {
  Future<dynamic> getSeries(String path, Map<String, dynamic> param);
}

class SeriesProvider implements ISeriesProvider {
  final ApiService apiService = ApiService(http.Client());

  @override
  Future<dynamic> getSeries(
    String path, Map<String, dynamic> param
  ) =>
      apiService.send(Request(path, RequestMethod.get, param));
//post(path, {}, headers: {'Authorization': "Bearer " + AuthService.shared.accessToken});
}
