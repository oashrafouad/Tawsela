import 'package:http/http.dart';
import 'dart:convert';

import 'package:tawsela_app/utilities.dart';

//TODO: add variables for all url endpoints
class ApiService {
  static Future<void> signUp({
    required String phoneNumber,
    required String fname,
    required String lname,
    String? gender,
    int? age,
    required String password,
    required String typeUser,
    String? Email_ID,
  }) async {
    final url = Uri.parse('$server_url/api/users');
    final response = await post(
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
    final error = handleError(response);
    if (error != null) {
      throw error;
    }
  }

  static String? handleError(Response response) {
    String? error;
    switch (response.statusCode) {
      case 200:
        error = null;
        break;
      case 201:
        error = null;
        break;
      case 409: // TODO: add another switch case inside that for each API request type
        // error = 'Phone already exists';
      error = response.body;
        break;
      case 404:
        error = 'Not found';
        break;
      case 500:
        error = 'Internal server error';
        break;
      default:
        print("default case");
        error = response.body;
        break;
    }
    print(error);
    // print(response.body);
    return error;

    //
    // if (response.statusCode == 201) {
    //   // Handle successful response
    //   print('Sign-up successful');
    // } else {
    //   print(response.statusCode)
    //   // Throw an error if sign-up fails
    //   throw (response.body);
    // }
  }

}
