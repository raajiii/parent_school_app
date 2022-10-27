import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../apihelper/api_helper.dart';
import '../../model/login_model.dart';
import '../../services/base_client.dart';
import '../../view/dialogs/dialog_helper.dart';
import '../../view/screens/storage.dart';

class LoginController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool visiblePassword = false;
  LoginModel? loginModel;
  FocusNode userName = FocusNode();
  FocusNode password = FocusNode();

  void togglePasswordView() {
    visiblePassword = !visiblePassword;
    update();
  }

  Future<LoginModel?> loginAuthentication(Map<String, dynamic> userData) async {
    showLoadingDialog(Get.context!);
    try {
      final result =
          await BaseService().loginAuth(userData, ApiHelper.loginUrl);
      if (result != null) {
        if (result.statusCode == 200) {
          loginModel = LoginModel.fromJson(result.data);
          LocalStorage.setValue('login', true);
          LocalStorage.setValue('token', loginModel?.loginData?.token ?? "");
          LocalStorage.setValue("studentId", loginModel?.loginData?.studentId);
          LocalStorage.setValue("code", loginModel?.loginData?.code);
          LocalStorage.setValue("username", loginModel?.loginData?.username);
          LocalStorage.setValue("phoneNumber", loginModel?.loginData?.phone);
          LocalStorage.setValue("photo", loginModel?.loginData?.photo);
          print(
              "studentId ${loginModel?.loginData?.studentId} ${loginModel?.loginData?.token}");
        } else {
          loginModel = LoginModel(
              status: "Failed",
              code: 400,
              message: result.data.containsKey("message")
                  ? result.data["message"]
                  : "");
        }
      }
    } catch (e) {
      print('Login Screen $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
    return loginModel;
  }
}
