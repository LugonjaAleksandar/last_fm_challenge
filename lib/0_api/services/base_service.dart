import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:last_fm_challenge/0_api/model/pagination/paginated_response.dart';
import 'package:last_fm_challenge/utilities/app_config.dart';

class BaseService {
  List _successStatusCodes = [200, 201];

  ApiResponse handlePaginatedResponse({
    http.Response serverResponse,
    Function objectConstructor,
  }) {
    if (_successStatusCodes.contains(serverResponse.statusCode)) {
      final PaginatedResponse paginatedResponse = PaginatedResponse.fromJson(json.decode(serverResponse.body), objectConstructor);
      return ApiResponse(responseObject: paginatedResponse);
    } else {
      final ApiError error = responseHasError(serverResponse.body);
      return ApiResponse(error: error);
    }
  }

  String urlWithParameters({String endpoint, Map<String, String> parameters}) {
    final Uri uri = Uri.parse(AppConfig.baseUrl);
    parameters['api_key'] = AppConfig.sounderFMApiKey;
    parameters['method'] = endpoint;
    parameters['format'] = 'json';

    if (uri.isScheme('https')) {
      return Uri.https(uri.authority, uri.path, parameters).toString();
    } else {
      return Uri.http(uri.authority, uri.path, parameters).toString();
    }
  }

  ApiError responseHasError(String responseBody) {
    ApiError error;
    try {
      error = ApiError.fromJson(json.decode(responseBody));
    } on FormatException catch (err) {
      error = ApiError(message: err.message, serverCode: "500");
    }
    if ((error.message.length > 0 || error.serverCode.length > 0)) {
      print('API ERROR =========================\n' + error.message);
      return error;
    } else {
      return null;
    }
  }
}

class ApiResponse {
  dynamic responseObject;
  ApiError error;

  ApiResponse({
    this.responseObject,
    this.error,
  });
}

class ApiError {
  String serverCode;
  String message;

  ApiError({
    this.serverCode,
    this.message,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) {
    if (json is Map) {
      if (json.containsKey('non_field_errors')) {
        return ApiError(
          serverCode: 'non_field_errors',
          message: (json['non_field_errors'] as List).join('\n'),
        );
      } else {
        String finalMessages = '';
        String finalCodes = '';

        json.keys.forEach((errorListKey) {
          finalCodes += errorListKey + '\n';
          if (json[errorListKey] is List) {
            finalMessages += json[errorListKey].join('\n') + '\n';
          } else {
            finalMessages += json[errorListKey] + '\n';
          }
        });

        return ApiError(
          serverCode: finalCodes,
          message: finalMessages,
        );
      }
    }
    return null;
  }
}
