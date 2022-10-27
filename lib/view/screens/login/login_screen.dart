import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../const/colors.dart';
import '../../../const/contsants.dart';
import '../../../const/image_constants.dart';
import '../../../controllers/login_controller/login_controller.dart';
import '../../../model/login_model.dart';
import '../../dialogs/dialog_helper.dart';
import '../../widgets/common_widgets.dart';
import '../Home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (loginController) => Stack(
        children: [
          _loinBg(),
          _smsIcon(),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 0),
            child: Form(
              key: globalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _loginText(),
                  _userNameTextField(context, loginController),
                  _pwdTextField(context, loginController),
                  // _forgetPasswordText(),
                  SMSButtonWidget(
                    onPress: () async {
                      if (!globalKey.currentState!.validate()) {
                        showToastMsg(Constants.login_key6);
                      } else {
                        Map<String, dynamic> mapData = {
                          "code":
                              loginController.userNameController.text.trim(),
                          "password": loginController.passwordController.text
                        };
                        LoginModel? loginModel =
                            await loginController.loginAuthentication(mapData);
                        if (loginModel != null && loginModel.code == 200) {
                          showToastMsg(loginModel.loginData?.message ?? "");
                          Get.offAll(HomeScreen());
                        } else {
                          showToastMsg(loginModel?.message ?? "");
                        }
                      }
                    },
                    text: Constants.login_key5,
                    primaryColor: AppColors.darkPinkColor,
                    onPrimaryColor: AppColors.whiteColor,
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 45,
                    borderRadius: 32,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loinBg() {
    return const SMSImageAsset(
      image: ImageConstants.loginBgImg,
      boxfit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    );
  }

  Widget _smsIcon() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 40),
      child: SMSImageAsset(
        image: ImageConstants.smsBandSplashImg,
        boxfit: BoxFit.cover,
        height: MediaQuery.of(Get.context!).size.height * 0.15,
        width: MediaQuery.of(Get.context!).size.width * 0.4,
      ),
    );
  }

  Widget _loginText() {
    return Text(Constants.login_key1,
        style: arimoBoldTextStyle(fontSize: 16, color: AppColors.blackColor));
  }

  Widget _userNameTextField(
      BuildContext context, LoginController loginController) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.55,
      child: SMSInputText(
          hintText: Constants.login_key1,
          focusNode: loginController.userName,
          textCapitalization: TextCapitalization.characters,
          controller: loginController.userNameController,
          prefixIcon: const Icon(
            Icons.person,
            color: AppColors.greyColor,
          ),
          onChanged: (val) {},
          validator: (userName) {
            if (userName == null || userName.isEmpty) {
              return Constants.login_key7;
            }
            return null;
          },
          lableText: Constants.login_key2,
          lablestyle: arimoRegularTextStyle(
              fontSize: 14,
              color: loginController.userName.hasFocus
                  ? AppColors.darkPinkColor
                  : AppColors.greyColor)),
    );
  }

  Widget _pwdTextField(BuildContext context, LoginController loginController) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.55,
      child: SMSInputText(
        obscureText: !loginController.visiblePassword,
        hintText: Constants.login_key3,
        focusNode: loginController.password,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.visiblePassword,
        prefixIcon: const Icon(
          Icons.lock,
          color: AppColors.greyColor,
        ),
        controller: loginController.passwordController,
        onChanged: (val) {},
        validator: (password) {
          if (password == null || password.isEmpty) {
            return Constants.login_key8;
          } else if (password.length < 6) {
            return Constants.login_key9;
          }
          return null;
        },
        suffixIcon: InkWell(
          onTap: () {
            loginController.togglePasswordView();
          },
          child: Icon(
            loginController.visiblePassword
                ? Icons.visibility_off
                : Icons.visibility,
            color: AppColors.greyColor,
          ),
        ),
        lableText: Constants.login_key3,
        lablestyle: arimoRegularTextStyle(
            fontSize: 14,
            color: loginController.userName.hasFocus
                ? AppColors.darkPinkColor
                : AppColors.greyColor),
      ),
    );
  }

  Widget _forgetPasswordText() {
    return Text(
      Constants.login_key4,
      style: arimoBoldTextStyle(
          fontSize: 14, color: AppColors.darkPinkColor, letterSpacing: 1.5),
    ).paddingOnly(left: 8, right: 8, top: 8, bottom: 20);
  }
}
