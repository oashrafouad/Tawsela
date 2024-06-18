import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:tawsela_app/models/data_models/user_request_model/request_model.dart';
import 'package:tawsela_app/models/data_models/trip_model/trip.dart';
import 'package:tawsela_app/models/passenger_bloc/server.dart';
import 'package:http/http.dart' as http;

class MainServer {
  static final serverUrl =
      GetIt.instance.get<Server>(instanceName: 'main-server').url;

  /* CREATE TRIP */

  static Future<void> createTrip({required Trip trip}) async {
    // forming url
    final String endPoint = MainServer.serverUrl + '/api/trips';
    // posting request data
    http.post(Uri.parse(endPoint), body: trip.toJson());
  }

  /* GET_TRIP_BY_ID */
  static Future<Trip> getTripById({required String trip_id}) async {
    // forming url
    final String endPoint = MainServer.serverUrl + '/api/trips/' + trip_id;
    //fetching data from server
    http.Response response = await http.get(Uri.parse(endPoint));
    // decoding json string
    Map<String, dynamic> json =
        jsonDecode(response.body) as Map<String, dynamic>;
    // deserialize json object to Trip class
    return Trip.fromJson(json);
  }

  /* CREATE A USER REQUEST */
  static Future<void> createRequest({required UserRequest request}) async {
    // forming url
    final String endPoint = MainServer.serverUrl + '/api/requests';
    // posting trip data
    http.post(Uri.parse(endPoint), body: request.toJson());
  }

  /* ACCEPT REQUEST */
  static Future<void> acceptRequest(
      {required String request_id, required String driver_id}) async {
    final String endPoint = MainServer.serverUrl + '/api/accept-req';
    http.post(Uri.parse(endPoint), body: {
      "Accept_Req_ID": "${DateTime.now()}",
      "Req_ID": "${request_id}",
      "Driver_ID": "${driver_id}",
    });
  }

  static Future<int?> isAcceptedRequest({required String request_id}) async {
    final String endPoint =
        MainServer.serverUrl + '/api/accept-req/' + request_id;
    final http.Response response = await http.get(Uri.parse(endPoint));
    Map json = jsonDecode(response.body);
    return json['driver_id'];
  }

  static Future<List<UserRequest>> getAllRequests() async {
    // forming url
    final String endPoint = MainServer.serverUrl + '/api/requests';
    //fetching data from server
    http.Response response = await http.get(Uri.parse(endPoint));
    // decoding json string
    List json = jsonDecode(response.body) as List;
    // deserialize json object to Trip class
    List<UserRequest> requests =
        json.map((e) => UserRequest.fromJson(e)).toList();

    return requests;
  }

  static Future<UserRequest> getRequestById(
      {required String userRequestId}) async {
    // forming url
    final String endPoint =
        MainServer.serverUrl + '/api/requests/' + userRequestId;
    //fetching data from server
    http.Response response = await http.get(Uri.parse(endPoint));
    // decoding json string
    Map<String, dynamic> json =
        jsonDecode(response.body) as Map<String, dynamic>;
    // deserialize json object to Trip class
    UserRequest userRequest = UserRequest.fromJson(json);
    return userRequest;
  }

  static Future<void> deleteRequestById({required String userRequestId}) async {
    // forming url
    final String endPoint =
        MainServer.serverUrl + '/api/requests/' + userRequestId;
    //fetching data from server
    http.Response response = await http.delete(Uri.parse(endPoint));
    // decoding json string
    // Map<String, dynamic> json =
    //     jsonDecode(response.body) as Map<String, dynamic>;
    // // deserialize json object to Trip class
    // UserRequest userRequest = UserRequest.fromJson(json);
  }
}
