import 'dart:convert';
import 'dart:io';
import 'package:final_project/data/local/local_pref.dart';
import 'package:http/http.dart' as http;
import 'app_exception.dart';

mixin class ApiBaseHelper {
  static const String baseUrl = 'https://palmail.gsgtt.tech/api/';
  Map<String, String> get headers => {
        HttpHeaders.authorizationHeader: "Bearer ${SharedHelper().getToken()}",
        HttpHeaders.acceptHeader: 'application/json'
      };

  Future<dynamic> get(
    String url,
  ) async {
    var responseJson;
    try {
      final response =
          await http.get(Uri.parse(baseUrl + url), headers: headers);
      print(response.body);
      responseJson = _returnResponse(response.body, response.statusCode);
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
    Map<String, dynamic>? body,
  ) async {
    var responseJson;
    try {
      final response = await http.post(
        Uri.parse(baseUrl + url),
        headers: headers,
        body: body,
      );
      print(response.body);
      responseJson = _returnResponse(response.body, response.statusCode);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    if (responseJson == null) {
      throw UnExpectedResponseFormatException('null result');
    }
    return responseJson;
  }

  Future<dynamic> put(String url, Map<String, dynamic>? body) async {
    var responseJson;
    try {
      final response = await http.put(Uri.parse(baseUrl + url),
          body: body, headers: headers);
      print(response.body);
      responseJson = _returnResponse(response.body, response.statusCode);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    if (responseJson == null) {
      throw UnExpectedResponseFormatException('null result');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url, {Map<String, dynamic>? body}) async {
    var responseJson;
    try {
      final response = await http.delete(Uri.parse(baseUrl + url),
          body: body, headers: headers);
      print(response.body);
      responseJson = _returnResponse(response.body, response.statusCode);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    if (responseJson == null) {
      throw UnExpectedResponseFormatException('null result');
    }
    return responseJson;
  }

  Future<dynamic> postWithImage(String url, Map<String, String> body,
      {String? filePath}) async {
    if (filePath != null) {
      var request = http.MultipartRequest("POST", Uri.parse(baseUrl + url));
      var pic = await http.MultipartFile.fromPath('image', filePath);

      request.fields.addAll(body as Map<String, String>);

      request.files.add(pic);

      request.headers.addAll(headers);
      var response = await request.send();

      // stream.bytesToString()
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);

      return _returnResponse(responseString, response.statusCode);
    } else {
      body.addAll({'image': ''});
      return await post(url, body);
    }
  }

  dynamic _returnResponse(String body, int statusCode) {
    var responseJson;
    try {
      responseJson = json.decode(body);
    } catch (e) {
      throw UnExpectedResponseFormatException('not json format');
    }
    switch (statusCode) {
      case 200:
      case 201:
        return responseJson;
      case 400:
        throw BadRequestException(responseJson['message']);
      case 401:
      case 403:
        throw UnauthorisedException(responseJson['message']);
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${statusCode}');
    }
  }
}
