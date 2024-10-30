import 'package:http/http.dart' as http;
import '../../../../common/api/api_service.dart';
import '../../../../common/api/request.dart';

abstract class IRenderPdfProvider {
  Future<dynamic> getPdf(String path, dynamic params);

  Future<dynamic> getPdfView(
    String path,
  );

  Future<dynamic> exportPdf(
    String path,
  );

  Future<dynamic> getPdfDraftTicket(String path, dynamic params);
}

class RenderPdfProvider implements IRenderPdfProvider {
  final ApiService apiService = ApiService(http.Client());

  @override
  Future<dynamic> getPdf(String path, dynamic params) =>
      apiService.send(Request(path, RequestMethod.post, params));

  @override
  Future getPdfDraftTicket(String path, dynamic params) =>
      apiService.send(Request(path, RequestMethod.post, params));

  @override
  Future<dynamic> exportPdf(
    String path,
  ) =>
      apiService.send(Request(path, RequestMethod.get, {}));

  @override
  Future<dynamic> getPdfView(
    String path,
  ) =>
      apiService.send(Request(path, RequestMethod.get, {}));
}
