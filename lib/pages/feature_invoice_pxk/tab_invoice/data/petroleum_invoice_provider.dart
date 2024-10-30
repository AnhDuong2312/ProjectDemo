import '../../../../common/api/api_service.dart';
import 'package:http/http.dart' as http;

import '../../../../common/api/request.dart';

abstract class IPetroleumInvoiceProvider {
  Future<dynamic> fetchPetroleumInvoices(String path, dynamic params);
  Future<dynamic> sendEmail(String path, dynamic params);
  Future<dynamic> fetchGoodTypes(String path, dynamic params);
  Future<dynamic> exportPdf(String path);
}

class PetroleumInvoiceProvider implements IPetroleumInvoiceProvider {
  final ApiService apiService = ApiService(http.Client());

  @override
  Future<dynamic> fetchPetroleumInvoices(String path, dynamic params) =>
      apiService.send(Request(path, RequestMethod.get, params));

  @override
  Future<dynamic> sendEmail(String path, dynamic params) =>
      apiService.send(Request(path, RequestMethod.post, params));

  @override
  Future<dynamic> fetchGoodTypes(String path, dynamic params) =>
      apiService.send(Request(path, RequestMethod.get, params));

  @override
  Future<dynamic> exportPdf(String path) =>
      apiService.send(Request(path, RequestMethod.get, {}));
}
