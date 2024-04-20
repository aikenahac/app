import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:coinseek/core/api/api.dart';
import 'dart:io';
import 'package:coinseek/core/api/exceptions/bad_request.exception.dart';
import 'package:coinseek/core/api/exceptions/conflict.exception.dart';
import 'package:coinseek/core/api/exceptions/forbidden.exception.dart';
import 'package:coinseek/core/api/exceptions/unauthorized.exception.dart';
import 'package:coinseek/core/globals.dart';
import 'package:coinseek/utils/snackbar.util.dart';

// Class that holds all the network requests
class ApiClient {
  static String apiUrl = baseUrl;

  // GET function
  // Retrieves JSON data from the API to the app
  static Future<Map<String, dynamic>?> get(String endpoint) async {
    final url = Uri.parse(apiUrl + endpoint);

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final accessToken = await CSApi.auth.getToken();

    if (accessToken != '/') {
      headers.addAll({
        'Authorization': 'Bearer $accessToken',
      });
    }

    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 204) return null;

    final Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (response.statusCode > 299) {
      String message = responseBody['message'];

      // showSnackbar(message);
      switch (response.statusCode) {
        case 400:
          throw BadRequestException(message);
        case 401:
          throw UnauthorizedException(message);
        case 403:
          throw ForbiddenException(message);
        case 409:
          throw ConflictException(message);
      }
    }

    return responseBody;
  }

  // GET function
  // Retrieves JSON data from the API to the app
  static Future<dynamic> getMany(String endpoint) async {
    final url = Uri.parse(apiUrl + endpoint);

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final accessToken = await CSApi.auth.getToken();

    if (accessToken != '/') {
      headers.addAll({
        'Authorization': 'Bearer $accessToken',
      });
    }

    final response = await http.get(
      url,
      headers: headers,
    );

    final Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (response.statusCode > 299) {
      String message = responseBody['message'];

      showSnackbar(message);
      switch (response.statusCode) {
        case 400:
          throw BadRequestException(message);
        case 401:
          throw UnauthorizedException(message);
        case 403:
          throw ForbiddenException(message);
        case 409:
          throw ConflictException(message);
      }
    }

    return responseBody;
  }

  // POST function
  // Sends JSON data to the app from the API
  // Used for adding new items
  static Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic>? body) async {
    final url = Uri.parse(apiUrl + endpoint);

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final accessToken = await CSApi.auth.getToken();

    if (accessToken != '/') {
      headers.addAll({
        'Authorization': 'Bearer $accessToken',
      });
    }

    final response = await http.post(
      url,
      headers: headers,
      body: body == null ? null : jsonEncode(body),
    );

    final Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (response.statusCode > 299) {
      final rspMsg = responseBody['message'];
      String message = '';
      if (rspMsg is List<dynamic>) {
        for (String el in rspMsg) {
          message.isEmpty ? message = el : message = '$message\n\n$el';
        }
      } else {
        message = rspMsg;
      }

      showSnackbar(message);
      switch (response.statusCode) {
        case 400:
          throw BadRequestException(message);
        case 401:
          throw UnauthorizedException(message);
        case 403:
          throw ForbiddenException(message);
        case 409:
          throw ConflictException(message);
      }
    }

    return responseBody;
  }

  // PUT function
  // Sends JSON data to the app from the API
  // Used for updating existing items
  static Future<Map<String, dynamic>> put(String endpoint,
      [Map<String, dynamic>? body]) async {
    final url = Uri.parse(apiUrl + endpoint);

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final accessToken = await CSApi.auth.getToken();

    if (accessToken != '/') {
      headers.addAll({
        'Authorization': 'Bearer $accessToken',
      });
    }

    final response = await http.put(
      url,
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );

    final Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (response.statusCode > 299) {
      String message = responseBody['message'];

      showSnackbar(message);
      switch (response.statusCode) {
        case 400:
          throw BadRequestException(message);
        case 401:
          throw UnauthorizedException(message);
        case 403:
          throw ForbiddenException(message);
        case 409:
          throw ConflictException(message);
      }
    }

    return responseBody;
  }

  // DELETE function
  // Deletes an existing item from the app
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final url = Uri.parse(apiUrl + endpoint);

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final accessToken = await CSApi.auth.getToken();

    if (accessToken != '/') {
      headers.addAll({
        'Authorization': 'Bearer $accessToken',
      });
    }

    final response = await http.delete(
      url,
      headers: headers,
    );

    final Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (response.statusCode > 299) {
      String message = responseBody['message'];

      showSnackbar(message);
      switch (response.statusCode) {
        case 400:
          throw BadRequestException(message);
        case 401:
          throw UnauthorizedException(message);
        case 403:
          throw ForbiddenException(message);
        case 409:
          throw ConflictException(message);
      }
    }

    return responseBody;
  }

  // POST function
  // Sends JSON data to the app from the API
  // Used for uploading images
  static Future<Map<String, dynamic>> postImage(
      String endpoint, File file) async {
    final url = Uri.parse(apiUrl + endpoint);
    final stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
    final length = await file.length();

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final accessToken = await CSApi.auth.getToken();

    if (accessToken != '/') {
      headers.addAll({
        'Authorization': 'Bearer $accessToken',
      });
    }

    final request = http.MultipartRequest("POST", url);
    final multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(file.path));

    request.files.add(multipartFile);
    request.headers.addAll(headers);

    final response = await request.send();
    final responseBody =
        (await response.stream.transform(utf8.decoder).toList())[0];
    final body = jsonDecode(responseBody);

    if (response.statusCode > 299) {
      switch (response.statusCode) {
        case 400:
          throw BadRequestException('Bad request');
        case 401:
          throw UnauthorizedException('Unauthorized');
        case 403:
          throw ForbiddenException('Forbidden');
      }
    }

    return body;
  }
}
