import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AcceptedRequest {
  final String? accept_req_id;
  // final String? driver_id;
  final String? req_id;
  final String? phone_num;
  final String? f_name;
  final String? l_name;
  AcceptedRequest({
    required this.accept_req_id,
    // required this.driver_id,
    required this.req_id,
    required this.phone_num,
    required this.f_name,
    required this.l_name,
  });
  factory AcceptedRequest.fromJson(Map<String, dynamic> json) {
    return AcceptedRequest(
        accept_req_id: json['accept_req_id'] as String?,
        // driver_id: json['driver_id'] as String?,
        req_id: json['req_id'] as String?,
        phone_num: json['phone_num'] as String?,
        f_name: json['f_name'] as String?,
        l_name: json['l_name'] as String?);
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Accept_req_id': this.accept_req_id,
      // 'driver_id': this.driver_id,
      'Req_ID': this.req_id,
      'Phone_num': this.phone_num,
      // 'f_name': this.f_name,
      // 'l_name': this.l_name,
    };
  }
}
