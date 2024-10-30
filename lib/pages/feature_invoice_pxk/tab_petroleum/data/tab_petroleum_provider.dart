import 'package:http/http.dart' as http;
import '../../../../common/api/api_service.dart';
import '../../../../common/api/request.dart';

abstract class ITabPetroleumProvider {
  Future<dynamic> getProducts(String path, dynamic params);

  Future<dynamic> getSystemFormatNumbers(
    String path,
  );

  Future<dynamic> createInvoice(String path, dynamic params);

  Future<dynamic> hsmInvoiceSign(String path, dynamic params);

  Future<dynamic> getInformationSeller(String path, dynamic params);

  Future<dynamic> sendEmail(String path, dynamic params);

  Future<dynamic> viewDraftTicket(String path, dynamic params);

  Future<dynamic> searchTax(String path, dynamic params);

  Future<dynamic> createInvoiceDataLog(String path, dynamic params);

  Future<dynamic> numberToWord(String path, dynamic params);

  Future<dynamic> fetchNameConfig(String path, dynamic params);
}

class TabPetroleumProvider implements ITabPetroleumProvider {
  final ApiService apiService = ApiService(http.Client());

  @override
  Future<dynamic> getProducts(String path, dynamic params) =>
      apiService.send(Request(path, RequestMethod.get, params));

  @override
  Future<dynamic> getSystemFormatNumbers(
    String path,
  ) =>
      apiService.send(Request(path, RequestMethod.get, {}));

  @override
  Future<dynamic> createInvoice(String path, dynamic params) =>
      apiService.send(Request(path, RequestMethod.post, params));

  @override
  Future<dynamic> hsmInvoiceSign(String path, dynamic params) =>
      apiService.send(Request(path, RequestMethod.post, params));

  @override
  Future<dynamic> getInformationSeller(String path, dynamic params) =>
      apiService.send(Request(path, RequestMethod.get, params));

  @override
  Future<dynamic> sendEmail(String path, dynamic params) =>
      apiService.send(Request(path, RequestMethod.post, params));

  @override
  Future<dynamic> viewDraftTicket(String path, dynamic params) =>
      apiService.send(Request(path, RequestMethod.post, params));

  @override
  Future<dynamic> searchTax(String path, dynamic params) =>
      apiService.send(Request(path, RequestMethod.get, params));

  @override
  Future<dynamic> createInvoiceDataLog(String path, dynamic params) =>
      apiService.send(Request(path, RequestMethod.post, params));

  @override
  Future<dynamic> numberToWord(String path, dynamic params) =>
      apiService.send(Request(path, RequestMethod.get, params));

  @override
  Future<dynamic> fetchNameConfig(String path, dynamic params) =>
      apiService.send(Request(path, RequestMethod.get, params));
}
