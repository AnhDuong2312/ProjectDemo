

import 'package:http/http.dart' as http;

import '../../../../common/api/api_service.dart';
import '../../../../common/api/request.dart';

abstract class ISerialProvider {
  Future<dynamic> getSerial(
    String path,
  );

  Future<dynamic> createTicketDraft(String path, Map<String, dynamic> param);

  Future<dynamic> releaseTicket(String path, Map<String, dynamic> param);
}

class SerialProvider implements ISerialProvider {
  final ApiService apiService = ApiService(http.Client());

  @override
  Future<dynamic> getSerial(
    String path,
  ) =>
      apiService.send(Request(path, RequestMethod.get, {}));

  @override
  Future<dynamic> createTicketDraft(String path, Map<String, dynamic> param) =>
      apiService.send(Request(path, RequestMethod.post, param));

  @override
  Future<dynamic> releaseTicket(String path, Map<String, dynamic> param) =>
      apiService.send(Request(path, RequestMethod.post, param));
}
