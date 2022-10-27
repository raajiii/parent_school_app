import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../const/colors.dart';
import '../../const/image_constants.dart';
import '../../controllers/daily_activity_controller/home_work_controller/homework_controller.dart';
import '../../enums/enum_navigation.dart';
import '../../routes/app_routes.dart';
import '../../themes/app_styles.dart';

class SMSImageAsset extends StatelessWidget {
  final String image;
  final BoxFit? boxfit;
  final double? height;
  final double? width;

  const SMSImageAsset(
      {Key? key, required this.image, this.boxfit, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      fit: boxfit,
      height: height,
      width: width,
    );
  }
}

class SMSInputText extends StatelessWidget {
  const SMSInputText(
      {Key? key,
      required this.onChanged,
      required this.hintText,
      this.validator,
      this.obscureText = false,
      this.keyboardType,
      this.suffixIcon,
      this.prefixIcon,
      required this.lableText,
      this.textInputAction,
      required this.controller,
      this.textCapitalization,
      required this.lablestyle,
      this.focusNode})
      : super(key: key);

  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String lableText;
  final TextInputAction? textInputAction;
  final TextEditingController controller;
  final TextCapitalization? textCapitalization;
  final TextStyle lablestyle;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        // contentPadding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
        // hintText: hintText,
        filled: true,
        labelText: lableText,
        labelStyle: lablestyle,
        errorStyle: const TextStyle(height: 0, color: AppColors.redColor),
        // hintStyle: const TextStyle(
        //   fontSize: 16,
        //   color: Color(0xFF969A9D),
        //   fontWeight: FontWeight.w300,
        // ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide:
                const BorderSide(color: AppColors.greyColor, width: 1.5)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide:
                const BorderSide(color: AppColors.greyColor, width: 1.5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide:
                const BorderSide(color: AppColors.darkPinkColor, width: 2.5)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: AppColors.redColor, width: 1.5),
        ),
      ),
      style: const TextStyle(
        fontSize: 16,
        color: Color(0xFF3C3C43),
      ),
    );
  }
}

class SMSButtonWidget extends StatelessWidget {
  final String text;
  final Color? primaryColor;
  final Color? onPrimaryColor;
  final Function() onPress;
  final double width;
  final double height;
  final double borderRadius;
  final double? fontSize;

  const SMSButtonWidget(
      {Key? key,
      required this.onPress,
      required this.text,
      this.onPrimaryColor,
      this.primaryColor,
      required this.width,
      required this.height,
      required this.borderRadius,
      this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: onPrimaryColor ?? AppColors.whiteColor,
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Text(text,
          style: AppStyles.arimBold.copyWith(
              fontSize: fontSize, color: Colors.white, letterSpacing: 1)),
    );
  }
}

PreferredSizeWidget smsAppbar(String text) {
  return AppBar(
      title:
          Text(text, style: AppStyles.NunitoExtrabold.copyWith(fontSize: 18)),
      leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
            size: 28,
          )),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: <Color>[AppColors.indigo1Color, AppColors.indigo2Color],
        )),
      ));
}

Widget buildText(String text) {
  return Padding(
    padding: const EdgeInsets.all(3.0),
    child: Text(
      text,
      style:
          AppStyles.normal.copyWith(fontSize: 14, color: AppColors.blackColor),
    ),
  );
}

void updateStatusOfTheRoute(Status state) {
  switch (state) {
    case Status.HOMEWORK:
      {
        Get.toNamed(AppRoutes.HOMEWORK, arguments: const {"tag": "Homework"});
      }
      break;
    case Status.CLASSTEST:
      {
        Get.toNamed(AppRoutes.CLASSTEST, arguments: const {"tag": "ClassTest"});
      }
      break;
    case Status.ATTENDANCEDETAILS:
      {
        Get.toNamed(AppRoutes.ATTENDANCEDETAILS);
      }
      break;
    case Status.CLASSTIMETABLE:
      {
        Get.toNamed(AppRoutes.CLASSTIEMTABLE);
      }
      break;
    case Status.CIRCULAR:
      {
        Get.toNamed(AppRoutes.CIRCULAR, arguments: {"tag": "Circular"});
      }
      break;
    case Status.EVENT:
      {
        Get.toNamed(AppRoutes.EVENT, arguments: {"tag": "Event"});
      }
      break;
    case Status.NEWS:
      {
        Get.toNamed(AppRoutes.NEWS, arguments: {"tag": "News"});
      }
      break;
    case Status.SMS:
      {
        Get.toNamed(AppRoutes.SMSView, arguments: {"tag": "SMS"});
      }
      break;
    case Status.VOICE:
      {
        Get.toNamed(AppRoutes.VOICE, arguments: {"tag": "Voice"});
      }
      break;
    case Status.STAFFDETAILS:
      {
        Get.toNamed(AppRoutes.STAFFDETAILS);
      }
      break;
    case Status.VEHICLETRACKING:
      {
        Get.toNamed(AppRoutes.VEHICLETRACKING);
      }
      break;
    case Status.FEEPAYMENT:
      {
        Get.toNamed(AppRoutes.FEEPAYMENT);
      }
      break;
    case Status.FEEINVOICE:
      {
        Get.toNamed(AppRoutes.FEEINVOICE);
      }
      break;
    case Status.FEEPENDING:
      {
        Get.toNamed(AppRoutes.FEEPENDING);
      }
      break;
    case Status.EXAMRESULT:
      {
        Get.toNamed(AppRoutes.EXAMRESULT, arguments: {"name": "Exam Result"});
      }
      break;
    case Status.EXAMTIMETABLE:
      {
        Get.toNamed(AppRoutes.EXAMTIMETABLE,
            arguments: {"name": "Exam TimeTable"});
      }
      break;
    case Status.LIVECLASSES:
      {
        Get.toNamed(AppRoutes.LIVECLASSES);
      }
      break;
    case Status.STUDYLAB:
      {
        Get.toNamed(AppRoutes.STAFFDETAILS);
      }
      break;
    case Status.BARROWLIST:
      {
        Get.toNamed(AppRoutes.BAROWLIST);
      }
      break;
    case Status.RENEWLIST:
      {
        Get.toNamed(AppRoutes.RENEWLIST);
      }
      break;

    case Status.FINELIST:
      {
        Get.toNamed(AppRoutes.FINELIST);
      }
      break;
    case Status.FINEINVOICE:
      {
        Get.toNamed(AppRoutes.FINEINVOICELIST);
      }
      break;
    case Status.MATERIALBILL:
      {
        Get.toNamed(AppRoutes.MATERIALBILL);
      }
      break;
   /* case Status.MATERIALBILLISSUED:
      {
        Get.toNamed(AppRoutes.MATERIALBILL);
      }
      break;*/
    case Status.EXTRACURRICULAR:
      {
        Get.toNamed(AppRoutes.EXTRACURRICULAR);
      }
      break;
    case Status.REFRESHMENT:
      {
        Get.toNamed(AppRoutes.EXTRACURRICULAR);
      }
      break;
    case Status.SCHOOLCALENDER:
      {
        Get.toNamed(AppRoutes.SCHOOLCALENDER);
      }
      break;
    default:
      {}
      break;
  }
}

class SMSTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function()? onTap;

  SMSTextFieldWidget({required this.controller, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        readOnly: true,
        onTap: onTap,
        decoration: InputDecoration(
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          fillColor: Colors.white,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.circular(10)),
        ),
        style: AppStyles.NunitoRegular.copyWith(
            fontSize: 14, color: Colors.black));
  }
}

TextStyle arimoBoldTextStyle(
        {required double fontSize,
        required Color color,
        double? letterSpacing}) =>
    AppStyles.arimBold.copyWith(
        fontSize: fontSize, color: color, letterSpacing: letterSpacing ?? 0);
TextStyle arimoRegularTextStyle(
        {required double fontSize, required Color color}) =>
    AppStyles.arimoRegular.copyWith(fontSize: fontSize, color: color);
TextStyle nunitoRegularTextStyle(
        {required double fontSize, required Color color}) =>
    AppStyles.NunitoRegular.copyWith(fontSize: fontSize, color: color);
TextStyle nunitoExtraBoldTextStyle(
        {required double fontSize, required Color color}) =>
    AppStyles.NunitoExtrabold.copyWith(fontSize: fontSize, color: color);


Center circularProgressIndicator() => const Center(child: CircularProgressIndicator.adaptive());



void showBottomModelSheet(BuildContext ctx, HomeworkController controller) {
  showModalBottomSheet(
      elevation: 10,
      backgroundColor: Colors.white,
      context: ctx,
      builder: (ctx) => Container(
        height: Get.height * 0.26,
        color: Colors.white54,
        alignment: Alignment.center,
        child: Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Pick File/Image",
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ).paddingOnly(bottom: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                      controller.filePicker();
                    },
                    child: Column(
                      children: [
                        Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              border: Border.all(
                                  width: 1,
                                  color: Colors.red,
                                  style: BorderStyle.solid),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              alignment: Alignment.center,
                              ImageConstants.galleryImg,
                              color: AppColors.whiteColor,
                            ).paddingOnly(top: 15, bottom: 15)),
                        Text("Gallery",
                            style: AppStyles.arimoRegular.copyWith(
                                fontSize: 14,
                                color: AppColors.greyColor))
                            .paddingOnly(top: 10)
                      ],
                    ).paddingAll(8),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                      controller.captureImage();
                    },
                    child: Column(
                      children: [
                        Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              border: Border.all(
                                  width: 1,
                                  color: Colors.purple,
                                  style: BorderStyle.solid),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              ImageConstants.cameraImg,
                              height: 20,
                              width: 20,
                              color: AppColors.whiteColor,
                            ).paddingOnly(top: 15, bottom: 15)),
                        Text("Camera",
                            style: AppStyles.arimoRegular.copyWith(
                                fontSize: 14,
                                color: AppColors.greyColor))
                            .paddingOnly(top: 10)
                      ],
                    ).paddingAll(8),
                  ),
                ],
              ).paddingOnly(left: 5),
            ],
          ),
        ),
      ));
}