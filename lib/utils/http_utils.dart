import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<http.Response> getRequest(
    String endpoint, Map<String, String> headers) async {
  try {
    final response = await http.get(
      Uri.parse(endpoint),
      headers: headers,
    );
    // ignore: avoid_print
    print('Api Request: $endpoint');

    // ignore: avoid_print
    print('Api Response: [${response.statusCode}] ${response.body}');

    return response;
  } catch (e) {
    if (e is TimeoutException) {
      // ignore: avoid_print
      print('Timeout occurred. Please try again later.');
      return http.Response('Timeout occurred', 504);
    } else {
      // ignore: avoid_print
      print('An error occurred during the HTTP request: $e');
      return http.Response('Internal server error', 500);
    }
  }
}

Future<http.Response> postRequest(
    String endpoint, Map<String, String> headers, dynamic requestBody) async {
  try {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: headers,
      body: json.encode(requestBody),
    );
    // ignore: avoid_print
    print('Api Request: $endpoint');

    // ignore: avoid_print
    print('JsonData: ${json.encode(requestBody)}');
    // ignore: avoid_print
    print('Api Response: [${response.statusCode}] ${response.body}');

    return response;
  } catch (e) {
    if (e is TimeoutException) {
      // ignore: avoid_print
      print('Timeout occurred. Please try again later.');
      return http.Response('Timeout occurred', 504);
    } else {
      // ignore: avoid_print
      print('An error occurred during the HTTP request: $e');
      return http.Response('Internal server error', 500);
    }
  }
}

Future<http.Response> putRequest(
    String endpoint, Map<String, String> headers, dynamic requestBody) async {
  try {
    final response = await http.put(
      Uri.parse(endpoint),
      headers: headers,
      body: json.encode(requestBody),
    );
    // ignore: avoid_print
    print('Api Request: $endpoint');

    // ignore: avoid_print
    print('JsonData: ${json.encode(requestBody)}');
    // ignore: avoid_print
    print('Api Response: [${response.statusCode}] ${response.body}');

    return response;
  } catch (e) {
    if (e is TimeoutException) {
      // ignore: avoid_print
      print('Timeout occurred. Please try again later.');
      return http.Response('Timeout occurred', 504);
    } else {
      // ignore: avoid_print
      print('An error occurred during the HTTP request: $e');
      return http.Response('Internal server error', 500);
    }
  }
}

Future<http.Response> deleteRequest(
    String endpoint, Map<String, String> headers) async {
  try {
    final response = await http.delete(
      Uri.parse(endpoint),
      headers: headers,
    );
    // ignore: avoid_print
    print('Api Request: $endpoint');
    // ignore: avoid_print
    print('Api Response: [${response.statusCode}] ${response.body}');

    return response;
  } catch (e) {
    if (e is TimeoutException) {
      // ignore: avoid_print
      print('Timeout occurred. Please try again later.');
      return http.Response('Timeout occurred', 504);
    } else {
      // ignore: avoid_print
      print('An error occurred during the HTTP request: $e');
      return http.Response('Internal server error', 500);
    }
  }
}
