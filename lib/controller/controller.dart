import 'package:get/get.dart';
import 'package:getx_state/service/api_service.dart';

class Controller extends GetxController {
  var loading = false.obs;

  void handleLoading() {
    loading.value = !loading.value;
  }

  void login(String email, String password) {
    var formData = {
      "username": email,
      "password": password,
    };

    ApiService().apiLogin(formData).then((value) {
      handleLoading();

      if (value.status)
      {
        print(value.message);
        print(value.user?.fullname);
      }
      else
      {
        print(value.message);
      }
    });
  }
}
