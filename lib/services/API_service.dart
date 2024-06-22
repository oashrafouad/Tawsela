import 'package:http/http.dart';
import 'dart:convert';

import 'package:tawsela_app/utilities.dart';

enum APIRequestType {
  signUp,
  logIn,
}

class ApiService {
  static Future<void> signUp({
    required String phoneNumber,
    required String fname,
    required String lname,
    required String typeUser,
    String? overallRating
  }) async {
    final url = Uri.parse('$server_url/api/users');
    final response = await post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'Phone_Num': phoneNumber,
        'F_Name': fname,
        'L_Name': lname,
        'Type_User': typeUser,
      }),
    );
    final error = handleError(response);
    if (error != null) {
      throw error;
    } else {
      await updateData();
    }
  }

  static Future<void> logIn({
    required String phoneNumber,
  }) async {
    final url = Uri.parse('$server_url/api/auth/login');
    final response = await post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'Phone_Num': phoneNumber,
      }),
    );
    print(response.body);
    final error = handleError(response);
    if (error != null) {
      throw error;
    } else {
      // Set the user as logged in
      isLoggedIn = true;
    }
  }

  static Future<void> deleteAccount({
    required String phoneNumber,
  }) async {
    final url = Uri.parse('$server_url/api/users/$phoneNumber');
    final response = await delete(url);

    final error = handleError(response);
    if (error != null) {
      throw error;
    } else {
      print("Phone number deleted successfully");
    }
  }

  static String? handleError(Response response) {
    String? error;
    switch (response.statusCode) {
      case 200: // Success
        error = null;
        break;
      case 201: // Created or updated
        error = null;
        break;
      case 404: // Not found
        error = 'Not found';
        break;
      case 409: // Already exists error (conflict)
        switch (APIRequestType) { // Another switch case for personalized error messages based on the request type
          case signUp:
            error = 'Phone already exists';
            break;
          default:
            error = response.body;
            break;
        }
        error = response.body;
        break;
      case 500: // Internal server error (no internet connection, server down, etc.)
        error = 'Internal server error';
        break;
      default:
        error = response.body;
        break;
    }
    return error;
  }
}