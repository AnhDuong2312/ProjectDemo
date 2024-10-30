import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:icorp_print_ticket/common/mixins/controller_mixin.dart';
import 'package:icorp_print_ticket/routes/app_pages.dart';
import 'package:icorp_print_ticket/services/auth_service.dart';
import '../../../common/app_environment/app_environtment.dart';
import 'package:icorp_print_ticket/common/mixins/server_config_mixin.dart';

// ignore: import_of_legacy_library_into_null_safe
import '../api_error/api_error.dart';
import '../config/app_constant.dart';
import '../local_storage/local_storage.dart';
import 'request.dart';

enum Environment {
  production,
  performance,
  development,
}

class ApiService with ServerConfigMixin {
  final http.Client httpClient;

  ApiService(this.httpClient);

  Future<dynamic> send(Request request) async {
    try {
      switch (request.method) {
        case RequestMethod.post:
          return await _requestPost(request)
              .timeout(const Duration(seconds: AppConstant.requestTimeOut));
        case RequestMethod.get:
          return await _requestGet(request)
              .timeout(const Duration(seconds: AppConstant.requestTimeOut));
      }
    } on ApiError {
      rethrow;
    } on SocketException catch (se) {
      throw ApiError(se.message);
    } on http.ClientException catch (e) {
      log(e.message);
      throw ApiError(e.message ??
          'Không thể hoàn thành yêu cầu của bạn. Vui lòng thử lại.');
    } catch (e) {
      log(e.toString());
      throw ApiError(e.toString() ??
          'Không thể hoàn thành yêu cầu của bạn. Vui lòng thử lại.');
    }
  }

  Future<dynamic> _requestPost(Request request) async {
    log(json.encode(request.params));
    final uri = Uri.parse('${getEnvironment().serverURL}${request.route}');
    var headers = {'Content-Type': 'application/json'};
    final String? accessToken = LocalStorage().accessToken.val;
    if (accessToken != null && accessToken.isNotEmpty) {
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };
    }

    final body = json.encode(request.params);
    final response = await httpClient.post(uri, headers: headers, body: body);
    if (request.route.contains('ticket/print') ||
        request.route.contains('invoice/export')) {
      return response.bodyBytes;
    }
    return _processResponse(response);
  }

  Future<dynamic> _requestGet(Request request) async {
    var body = request.params;
    var uri = Uri();
    if (body.toString() == "{}") {
      uri = Uri.parse('${getEnvironment().serverURL}${request.route}');
    } else {
      uri = Uri.parse('${getEnvironment().serverURL}${request.route}')
          .replace(queryParameters: body);
    }
    var headers = {'Content-Type': 'application/json'};
    final String? accessToken = LocalStorage().accessToken.val;
    if (accessToken != null && accessToken.isNotEmpty) {
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };
    }
    final response = await httpClient.get(uri, headers: headers);
    if (request.route.contains('ticket/print') ||
        request.route.contains('ticket/export-by-id') ||
        request.route.contains('invoice/export')) {
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        print('loi server');
        throw ApiError('Lỗi server');
      }
    }
    return _processResponse(response);
  }

  dynamic _processResponse(http.Response response) {
    log(response.request!.url.toString());
    log(response.statusCode.toString());
    log(response.body);
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      if ((responseBody as Map<String, dynamic>).containsKey("result") &&
          responseBody["result"] == "Failed") {
        throw ApiError("Rất tiếc. Đã có lỗi xảy ra");
      }
      return responseBody;
    } else if (response.statusCode == 401) {
      AuthService.shared.logout();
      ControllerMixin().hideLoading();
      Get.offAllNamed(Routes.login);
    } else if (response.statusCode == 500) {
      throw ApiError('Lỗi server');
    } else if (response.statusCode == 502) {
      throw ApiError('Lỗi server');
    } else {
      var error = "Rất tiếc. Đã có lỗi xảy ra";
      final responseBody = jsonDecode(response.body);
      var responseError = responseBody["message"];
      if (responseError is List) {
        error = "";
        for (var element in responseError) {
          error += "$element \n";
        }
      } else {
        error = responseError;
      }
      throw ApiError(error);
    }
  }
}
