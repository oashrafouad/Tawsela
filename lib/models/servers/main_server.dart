import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:tawsela_app/models/data_models/accepted_request_model.dart/accepted_request.dart';
import 'package:tawsela_app/models/data_models/user_request_model/request_model.dart';
import 'package:tawsela_app/models/data_models/trip_model/trip.dart';
import 'package:http/http.dart' as http;
import 'package:tawsela_app/models/get_it.dart/key_chain.dart';
import 'package:tawsela_app/models/servers/local_server.dart';
import 'package:tawsela_app/models/servers/server.dart';

class MainServer {
  static final serverUrl =
      KeyChain.chain.get<LocalServer>(instanceName: 'main-server').url;

  /* CREATE TRIP */

  static Future<void> createTrip({required Trip trip}) async {
    // forming url
    final String endPoint = MainServer.serverUrl + '/api/trips';
    // posting request data
    http.post(Uri.parse(endPoint), body: trip.toJson());
    print('Trip created');
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
    print('get trip by id');
    return Trip.fromJson(json);
  }

  /* CREATE A USER REQUEST */
  static Future<void> createRequest({required UserRequest request}) async {
    // forming url
    final String endPoint = MainServer.serverUrl + '/api/requests';
    print(endPoint);
    // posting trip data\
    print('creating request');
    http.Response? response;
    try {
      // Dio().post(Uri.parse(endPoint),data: )
      response = await http.post(Uri.parse(endPoint),
          headers: <String, String>{
            'Authorization':
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MTg5MDYzMjEsImV4cCI6MTcxODkwNjYyMX0.m-W0ybwek7knJRI5slPfP_r5vcP7yD8xgTW54CwKt8E',
            'Content-Type': 'application/json;charset=UTF-8',
          },
          body: jsonEncode(request.toJson()));
    } catch (error) {
      print(error);
    }
    print('${response?.statusCode}');
    print('${response?.body}');
    print('Request has been made');
  }

  /* ACCEPT REQUEST */
  static Future<void> acceptRequest(
      {required String request_id, required String Phone_Num}) async {
    final String endPoint = MainServer.serverUrl + '/api/accept-req';
    http.Response? response;
    try {
      response = await http.post(Uri.parse(endPoint),
          headers: <String, String>{
            'Authorization':
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MTg5MjQ1OTAsImV4cCI6MTcxODkyNDg5MH0.D_aHDiEX32MCXef9wbu13ZFxeCKTXvcJaDJsnOxaRj8',
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8'
          },
          body: jsonEncode({
            "Accept_Req_ID": DateTime.now(),
            "Req_ID": request_id,
            "Phone_Num": Phone_Num,
          }));
    } catch (error) {
      print(error.toString() + 'acceptRequest function');
      print(response?.body);
    }
    print('request is accepted');
  }

  static Future<AcceptedRequest> isAcceptedRequest(
      {required String request_id}) async {
    final String endPoint =
        MainServer.serverUrl + '/api/accept-req/' + request_id;
    final http.Response response = await http.get(Uri.parse(endPoint));
    Map<String, dynamic> json = jsonDecode(response.body);
    return AcceptedRequest.fromJson(json);
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
    print(requests);
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
