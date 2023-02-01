import 'package:getx_state/model/user_model.dart';

class ResponseApi {
  final bool status;
  final String message;
  User? user;

  ResponseApi(this.status, this.message, this.user);

  ResponseApi.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        message = json['message'],
        user = json['data'] != null ? User.fromJson(json['data']) : json['data'];

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'user' : user,
      };
}