import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

void main() async {
  test('API Test', () async {
    var response = await http
        .get(Uri.parse('***REMOVED***/api/requests'));
    print(response);
  });
}
