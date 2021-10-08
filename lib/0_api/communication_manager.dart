import 'dart:convert';
import 'package:http/http.dart' as http;

class CommunicationManager {
  Future<http.Response> executeAuthorizedGet({
    String endpoint,
    Map headers,
  }) async {
    print('Executing GET for endpoint: ' + endpoint);
    return await _executeAuthorizedMethod(
      httpFunction: http.Client().get,
      endpoint: endpoint,
      headers: headers,
    );
  }

  Future<http.Response> executeAuthorizedPatch({
    String endpoint,
    Map headers,
    Map body,
  }) async {
    print('Executing PATCH for endpoint: ' + endpoint);

    return await _executeAuthorizedMethod(
      httpFunction: http.Client().patch,
      endpoint: endpoint,
      headers: headers,
      body: body,
    );
  }

  Future<http.Response> executeAuthorizedDelete({
    String endpoint,
    Map headers,
  }) async {
    print('Executing DELETE for endpoint: ' + endpoint);

    return await _executeAuthorizedMethod(
      httpFunction: http.Client().delete,
      endpoint: endpoint,
      headers: headers,
    );
  }

  Future<http.Response> executeAuthorizedPost({
    String endpoint,
    Map headers,
    Map body,
  }) async {
    print('Executing POST for endpoint: ' + endpoint);

    return await _executeAuthorizedMethod(
      httpFunction: http.Client().post,
      endpoint: endpoint,
      headers: headers,
      body: body,
    );
  }

  Future<http.Response> _executeAuthorizedMethod({
    Function httpFunction,
    String endpoint,
    Map headers,
    Map body,
  }) async {
    http.Response response = body != null
        ? await httpFunction(
            Uri.parse(endpoint),
            headers: headers,
            body: json.encode(body),
          )
        : await httpFunction(
            Uri.parse(endpoint),
            headers: headers,
          );

    return response;
  }
}
