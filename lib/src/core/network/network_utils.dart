import 'dart:convert';
import 'dart:io';
import 'package:club_cash/src/core/enums/app_enum.dart';
import 'package:club_cash/src/core/errors/messages.dart';
import 'package:club_cash/src/core/helpers/helper_methods.dart';
import 'package:club_cash/src/core/services/connectivity_services.dart';
import 'package:club_cash/src/core/services/local_storage.dart';
import 'package:http/http.dart' as http;

class Network {
  static Future<http.Response> getRequest({required String api, params}) async {
    if (!await ConnectivityService.hasInternet) {
      throw Message.noInternet;
    }

    kPrint("\nYou hit: $api");
    kPrint("Request Params: $params");

    var headers = {
      'Accept': 'application/json',
      "Authorization":
          "Bearer ${LocalStorage.getData(key: LocalStorageKey.token)}"
    };

    http.Response response = await http.get(
      Uri.parse(api).replace(queryParameters: params),
      headers: headers,
    );
    return response;
  }

  static Future<http.Response> postRequest({
    required String api,
    body,
    bool addContentType = false,
  }) async {
    if (!await ConnectivityService.hasInternet) {
      throw Message.noInternet;
    }

    kPrint('\nYou hit: $api');
    kPrint('Request Body: ${jsonEncode(body)}');

    var headers = {
      'Accept': 'application/json',
      "Authorization":
          "Bearer ${LocalStorage.getData(key: LocalStorageKey.token)}"
    };

    if (addContentType) {
      headers['Content-Type'] = 'application/json';
    }

    http.Response response = await http.post(
      Uri.parse(api),
      body: body,
      headers: headers,
    );

    return response;
  }

  static Future<http.Response> putRequest({
    required String api,
    body,
    bool addContentType = false,
  }) async {
    if (!await ConnectivityService.hasInternet) {
      throw Message.noInternet;
    }

    kPrint('\nYou hit: $api');
    kPrint('Request Body: ${jsonEncode(body)}');

    var headers = {
      'Accept': 'application/json',
      "Authorization":
          "Bearer ${LocalStorage.getData(key: LocalStorageKey.token)}"
    };

    if (addContentType) {
      headers['Content-Type'] = 'application/json';
    }

    http.Response response = await http.put(
      Uri.parse(api),
      body: body,
      headers: headers,
    );
    return response;
  }

  static Future<http.Response> deleteRequest({
    required String api,
    body,
  }) async {
    if (!await ConnectivityService.hasInternet) {
      throw Message.noInternet;
    }

    kPrint('\nYou hit: $api');
    kPrint('Request Body: ${jsonEncode(body)}');

    var headers = {
      'Accept': 'application/json',
      "Authorization":
          "Bearer ${LocalStorage.getData(key: LocalStorageKey.token)}"
    };

    http.Response response = await http.delete(
      Uri.parse(api),
      body: body,
      headers: headers,
    );
    return response;
  }

  static multipartAddRequest({
    required String api,
    required Map<String, String> body,
    required List<String> fileKeyNames,
    required List<String> filePaths,
  }) async {
    if (!await ConnectivityService.hasInternet) {
      throw Message.noInternet;
    }

    kPrint("\nYou hit: $api");
    kPrint("Request body: $body");

    var headers = {
      'Accept': 'application/json',
      "Authorization":
          "Bearer ${LocalStorage.getData(key: LocalStorageKey.token)}"
    };

    var request = http.MultipartRequest('POST', Uri.parse(api))
      ..fields.addAll(body)
      ..headers.addAll(headers);

    for (var i = 0; i < fileKeyNames.length; i++) {
      if (filePaths[i].isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath(fileKeyNames[i], filePaths[i]),
        );
      }
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return response;
  }

  static handleResponse(http.Response response) async {
    try {
      if (!await ConnectivityService.hasInternet) {
        throw Message.noInternet;
      }

      if (response.statusCode >= 200 && response.statusCode <= 210) {
        kPrint('SuccessCode: ${response.statusCode}');
        kPrint('SuccessResponse: ${response.body}');

        if (response.body.isNotEmpty) {
          return json.decode(response.body);
        } else {
          return response.body;
        }
      } else if (response.statusCode == 401) {
        _logout();
        String msg = Message.error401;
        if (response.body.isNotEmpty) {
          if (json.decode(response.body)['errors'] != null) {
            msg = json.decode(response.body)['errors'];
          }
        }
        throw msg;
      } else if (response.statusCode == 404) {
        throw Message.error404;
      } else if (response.statusCode == 500) {
        throw Message.error500;
      } else {
        kPrint('ErrorCode: ${response.statusCode}');
        kPrint('ErrorResponse: ${response.body}');

        String msg = Message.unknown;
        if (response.body.isNotEmpty) {
          var data = jsonDecode(response.body)['errors'];
          if (data == null) {
            msg = jsonDecode(response.body)['message'] ?? msg;
          } else if (data is String) {
            msg = data;
          } else if (data is Map) {
            msg = data['email'][0];
          }
        }

        throw msg;
      }
    } on SocketException catch (_) {
      throw Message.noInternet;
    } on FormatException catch (_) {
      throw Message.badResponse;
    } catch (e) {
      throw e.toString();
    }
  }

  static void _logout() {
    LocalStorage.removeData(key: LocalStorageKey.token);

    /// navigate login page
    // NavigationService.pushNamedAndRemoveUntil(
    //   newRouteName: RouteGenerator.login,
    // );
  }
}
