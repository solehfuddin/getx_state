import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:getx_state/model/response_model.dart';

import '../apikey.dart';

class ApiService {
  static const urlConfig = "http://ams-api.linetech.id";

  Future<ResponseApi> apiLogin (var data) async {
    late ResponseApi responseApi;
    
    try {
      var response = await Dio().post(
        "$urlConfig/login",
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "X-API-KEY": tokenConfig,
          },
        ),
        data: jsonEncode(data),
        cancelToken: CancelToken(),
      );

      responseApi = ResponseApi.fromJson(response.data);
    } on DioError catch (e) {
      String sts = "";
      if (e.response?.statusCode == 404) {
        sts = "Data not found";
      } else if (e.response?.statusCode == 403) {
        sts = "Invalid API key";
      } else {
        sts = "General Error";
      }

      responseApi = ResponseApi(false, sts, null);
    }

    return responseApi;
  }
}
