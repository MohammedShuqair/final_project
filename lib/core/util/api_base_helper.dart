import 'dart:convert';
import 'dart:io';
import 'package:final_project/data/local/local_pref.dart';
import 'package:http/http.dart' as http;
import 'app_exception.dart';

mixin class ApiBaseHelper {
  static const String baseUrl = 'https://palmail.gsgtt.tech/api/';
  Map<String, String>? get headers =>
      {HttpHeaders.authorizationHeader: "Bearer ${SharedHelper().getToken()}"};

  Future<dynamic> get(
    String url,
  ) async {
    var responseJson;
    try {
      final response =
          await http.get(Uri.parse(baseUrl + url), headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    if (responseJson == null) {
      throw UnExpectedResponseFormatException('null result');
    }
    return responseJson;
  }

  Future<dynamic> post(
    String url,
    Map<String, String> body,
  ) async {
    var responseJson;
    try {
      final response = await http.post(
        Uri.parse(baseUrl + url),
        headers: headers,
        body: body,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    if (responseJson == null) {
      throw UnExpectedResponseFormatException('null result');
    }
    return responseJson;
  }

  Future<dynamic> put(String url, Map<String, dynamic> body) async {
    var responseJson;
    try {
      final response = await http.put(Uri.parse(baseUrl + url),
          body: body, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    if (responseJson == null) {
      throw UnExpectedResponseFormatException('null result');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    try {
      var responseJson = json.decode(response.body.toString());
      switch (response.statusCode) {
        case 200:
          return responseJson;
        case 400:
          throw BadRequestException(responseJson['message']);
        case 401:
        case 403:
          throw UnauthorisedException(responseJson['message']);
        case 500:
        default:
          throw FetchDataException(
              'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
      }
    } catch (e) {
      throw UnExpectedResponseFormatException('not json format');
    }
  }
}
