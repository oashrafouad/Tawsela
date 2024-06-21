import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tawsela_app/utilities.dart';

class ApiService {
  static Future<void> signUp( {
    required String phoneNumber,
    required String fname,
    required String lname,
     String ?gender,
     int? age,
     required String password,
     String? typeUser,
     String? Email_ID,
  }) async {
    final url = Uri.parse('$server_url/api/users');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'Phone_Num': phoneNumber,
        'F_Name': fname,
        'L_Name': lname,
        'Gender': gender,
        'Age': age,
        'Password': password,
        'Type_User': typeUser,
        'Email_ID': Email_ID,
      }),
    );

    if (response.statusCode == 201) {
      // Handle successful response
      print('Sign-up successful');
    } else {
      // Throw an error if sign-up fails
      throw (response.body);
    }
  }
}
