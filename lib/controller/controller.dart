import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_state/service/api_service.dart';
import 'package:lottie/lottie.dart';

class Controller extends GetxController {
  var loading = false.obs;
  final _session = GetStorage();

  void handleLoading() {
    loading.value = !loading.value;
  }

  void login(BuildContext context, String email, String password) {
    var formData = {
      "username": email,
      "password": password,
    };

    ApiService().apiLogin(formData).then((value) {
      handleLoading();

      if (value.status) {
        print(value.message);
        print(value.user?.fullname);
        _session.write("fullname", value.user?.fullname);

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Welcome, ${_session.read("fullname")}"),
            content: Lottie.asset(
              'images/success.json',
              repeat: false,
              reverse: false,
              animate: true,
              width: 100,
              height: 100,
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Ok"),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(value.message),
            content: Lottie.asset(
              'images/failed.json',
              repeat: false,
              reverse: false,
              animate: true,
              width: 100,
              height: 100,
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Ok"),
              ),
            ],
          ),
        );
      }
    });
  }
}
