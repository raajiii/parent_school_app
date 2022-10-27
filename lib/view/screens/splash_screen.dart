import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../const/colors.dart';
import '../../const/contsants.dart';
import '../../const/image_constants.dart';
import '../../routes/app_routes.dart';
import '../../themes/app_styles.dart';
import '../widgets/common_widgets.dart';
import 'storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController lottieController;
  bool lottieValue = false;
  @override
  void initState() {
    super.initState();
    lottieController = AnimationController(
      vsync: this,
    );

    Timer(const Duration(milliseconds: 3000), () {
      lottieValue = true;
      setState(() {});
    });
    Timer(const Duration(milliseconds: 4000), () {
      if (LocalStorage.getValue('login') == true) {
        Get.offNamed(AppRoutes.HOMESCREEN);
      } else {
        Get.offNamed(AppRoutes.LOGINVIEW);
      }
    });
  }

  @override
  void dispose() {
    lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: lottieValue
            ? Stack(
                children: [
                  smsBandSplashWidget(),
                  cblazeinfotechText(),
                ],
              )
            : animatedSplashWidget());
  }

  Widget smsBandSplashWidget() => const Center(
          child: SMSImageAsset(
        image: ImageConstants.smsBandSplashImg,
        boxfit: BoxFit.fill,
      ));

  Widget animatedSplashWidget() => Center(
        child: Lottie.asset(ImageConstants.splashJsonImg,
            animate: false,
            controller: lottieController, onLoaded: (composition) {
          lottieController.duration = const Duration(milliseconds: 3200);
          lottieController.forward();
        }),
      );

  Widget cblazeinfotechText() => Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(Constants.DEVELOPEDBY),
          Text(Constants.CBLAZEINFOTECHTEXT,
              style: AppStyles.arimBold
                  .copyWith(fontSize: 16, color: AppColors.blackColor)),
        ],
      ));
}
