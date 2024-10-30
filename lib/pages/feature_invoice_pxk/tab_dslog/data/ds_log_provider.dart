import '../../../../common/api/api_service.dart';
import 'package:http/http.dart' as http;

import '../../../../common/api/request.dart';

abstract class IDSLogProvider {
  Future<dynamic> fetchLogs(String path, dynamic params);
  Future<dynamic> fetchStations(String path, dynamic params);
}

class DSLogProvider implements IDSLogProvider {
  final ApiService apiService = ApiService(http.Client());

  @override
  Future<dynamic> fetchLogs(String path, dynamic params) =>
      apiService.send(Request(path, RequestMethod.get, params));

  @override
  Future<dynamic> fetchStations(String path, dynamic params) =>
      apiService.send(Request(path, RequestMethod.get, params));
}
