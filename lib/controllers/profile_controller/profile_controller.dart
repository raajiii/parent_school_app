import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/profession_model.dart';
import '../../model/profile_model.dart';
import '../../model/profile_responce_model.dart';
import '../../model/religion_model.dart';
import '../../services/base_client.dart';
import '../../view/dialogs/dialog_helper.dart';

class ProfileController extends GetxController {
  bool fatherDetailsView = false;
  bool motherDetailsView = false;
  bool passportDetailsView = false;
  ProfileModel? profileModel;
  ProfileResponceModel? profileResponceModel;
  ReligionModel? religionModel;
  ProfessionModel? professionModel;
  TextEditingController fatherEmailController = TextEditingController();
  TextEditingController fatherMobileController = TextEditingController();
  TextEditingController fatherWhatsAppController = TextEditingController();
  TextEditingController fatherLandlineController = TextEditingController();
  TextEditingController fatherOfficeAddressController = TextEditingController();
  TextEditingController motherEmailController = TextEditingController();
  TextEditingController motherMobileController = TextEditingController();
  TextEditingController motherWhatsAppController = TextEditingController();
  TextEditingController motherLandlineController = TextEditingController();
  TextEditingController motherOfficeAddressController = TextEditingController();

  TextEditingController passportNoController = TextEditingController();
  TextEditingController dateOfIssueController = TextEditingController();
  TextEditingController dateOfExpiryController = TextEditingController();
  TextEditingController placeOfIssueController = TextEditingController();
  TextEditingController civilIdNoController = TextEditingController();
  TextEditingController resPermitNoController = TextEditingController();
  TextEditingController dateOfResPermitIssueController =
      TextEditingController();
  TextEditingController dateOfResPermitExpiryController =
      TextEditingController();
  TextEditingController enteredCountryDateController = TextEditingController();
  List<Datum> religionData = [];
  List<ProfessionDatum> professionData = [];
  String updateReligionSelectedValue = "";
  String updateProfessionSelectedValue = "";
  String religionId = "";
  String professionId = "";
  ImagePicker picker = ImagePicker();

  Future getReligion() async {
    try {
      final result = await BaseService().getData("ApiHelper.religionList");
      if (result != null) {
        if (result.statusCode == 200) {
          religionModel = ReligionModel.fromJson(result.data);
          religionData = religionModel?.data ?? [];
          religionId = religionData.first.id.toString();
        }
      }
    } catch (e) {
      print('Religion Screen $e');
    } finally {}
    update();
  }

  Future getProfession() async {
    try {
      final result = await BaseService().getData("ApiHelper.professionList");
      if (result != null) {
        if (result.statusCode == 200) {
          professionModel = ProfessionModel.fromJson(result.data);
          professionData = professionModel?.data ?? [];
          professionId = professionData.first.id.toString();
        }
      }
    } catch (e) {
      print('Religion Screen $e');
    } finally {}
    update();
  }

  Future<ProfileResponceModel?> fatherProfileEdit(
      Map<String, dynamic> userData) async {
    showLoadingDialog(Get.context!);
    try {
      final result =
          await BaseService().postData(userData, "ApiHelper.profileEdit");
      if (result != null) {
        if (result.statusCode == 200) {
          profileResponceModel = ProfileResponceModel.fromJson(result.data);
        }
      }
    } catch (e) {
      print('fatherProfileEdit $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
    return profileResponceModel;
  }

  Future<ProfileResponceModel?> motherProfileEdit(
      Map<String, dynamic> userData) async {
    showLoadingDialog(Get.context!);
    try {
      final result =
          await BaseService().postData(userData, "ApiHelper.motherProfileEdit");
      if (result != null) {
        if (result.statusCode == 200) {
          profileResponceModel = ProfileResponceModel.fromJson(result.data);
        }
      }
    } catch (e) {
      print('motherProfileEdit $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
    return profileResponceModel;
  }

  Future<ProfileResponceModel?> fatherPassportProfileEdit(
      Map<String, dynamic> userData) async {
    showLoadingDialog(Get.context!);
    try {
      final result = await BaseService()
          .postData(userData, "ApiHelper.fatherPassportEditUrl");
      if (result != null) {
        if (result.statusCode == 200) {
          profileResponceModel = ProfileResponceModel.fromJson(result.data);
          print('mother 200 $profileResponceModel');
        }
      }
    } catch (e) {
      print('father-passport-edit profile $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
    return profileResponceModel;
  }

  Future getProfile() async {
    try {
      final result = await BaseService().getData("ApiHelper.profileUrl");
      if (result != null) {
        if (result.statusCode == 200) {
          profileModel = ProfileModel.fromJson(result.data);
        }
      }
    } catch (e) {
      print('Profile Screen $e');
    } finally {}
    update();
  }

  void religionUpdate(String selectedValue) {
    updateReligionSelectedValue = selectedValue;
    if (religionData.isNotEmpty) {
      List.generate(religionData.length, (index) {
        if (religionData[index].name == updateReligionSelectedValue) {
          religionId = religionData[index].id.toString();
        }
      });
    }
    update();
  }

  void professionUpdate(String selectedValue) {
    updateProfessionSelectedValue = selectedValue;
    if (professionData.isNotEmpty) {
      List.generate(professionData.length, (index) {
        if (professionData[index].name == updateProfessionSelectedValue) {
          professionId = professionData[index].id.toString();
        }
      });
    }
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // Future.delayed(const Duration(seconds: 1));
    Future.delayed(const Duration(seconds: 1), () {
      getProfile();
    });
  }

  Future pickGalleryImage(String url) async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    profilePhotoEdit(image!, url);
    update();
  }

  Future captureImage(String url) async {
    XFile? image = await picker.pickImage(source: ImageSource.camera,imageQuality: 25);
    profilePhotoEdit(image!, url);
    update();
  }

  Future profilePhotoEdit(XFile file, String url) async {
    showLoadingDialog(Get.context!);
    try {
      final result = await BaseService().multipartFormData(file, url);
      if (result != null) {
        if (result.statusCode == 200) {
          profileResponceModel = ProfileResponceModel.fromJson(result.data);
          getProfile();
          showToastMsg("Success");
        }else{
          showToastMsg("Failed");
        }
      }
    } catch (e) {
      print('Profile Screen $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
  }

  updateAfterEditing(
      {bool fatherDetails = true,
      bool motherDetails = true,
      bool fatherPassportDetails = true}) {
    fatherDetailsView = fatherDetails;
    motherDetailsView = motherDetails;
    passportDetailsView = fatherPassportDetails;
    update();
  }

  void checkEditView(int type) {
    if (type == 1) {
      //Father Details
      fatherDetailsView = !fatherDetailsView;
      if (profileModel?.profileData?.fatherDetail != null) {
        fatherEmailController.text =
            profileModel?.profileData?.fatherDetail?.email ?? "";
        fatherMobileController.text =
            profileModel?.profileData?.fatherDetail?.phoneNo ?? "";
        fatherWhatsAppController.text =
            profileModel?.profileData?.fatherDetail?.whatsAppNo ?? "";
        fatherLandlineController.text =
            profileModel?.profileData?.fatherDetail?.telephoneNo ?? "";
        fatherOfficeAddressController.text =
            profileModel?.profileData?.fatherDetail?.officeAddress ?? "";
        getProfession();
        getReligion();
      }
    } else if (type == 2) {
      //Mother Details
      motherDetailsView = !motherDetailsView;
      if (profileModel?.profileData?.motherDetail != null) {
        motherEmailController.text =
            profileModel?.profileData?.motherDetail?.email ?? "";
        motherMobileController.text =
            profileModel?.profileData?.motherDetail?.phoneNo ?? "";
        motherWhatsAppController.text =
            profileModel?.profileData?.motherDetail?.whatsAppNo ?? "";
        motherLandlineController.text =
            profileModel?.profileData?.motherDetail?.telephoneNo ?? "";
        motherOfficeAddressController.text =
            profileModel?.profileData?.motherDetail?.officeAddress ?? "";
        getProfession();
        getReligion();
      }
    } else if (type == 3) {
      //Passport Details
      passportDetailsView = !passportDetailsView;
      if (profileModel?.profileData?.passportDetail != null) {
        passportNoController.text =
            profileModel?.profileData?.passportDetail?.passportNo ?? "";
        dateOfIssueController.text =
            profileModel?.profileData?.passportDetail?.dateOfIssue ?? "";
        dateOfExpiryController.text =
            profileModel?.profileData?.passportDetail?.dateOfExpiry ?? "";
        dateOfResPermitIssueController.text =
            profileModel?.profileData?.passportDetail?.dateOfResPermitIssue ??
                "";
        civilIdNoController.text =
            profileModel?.profileData?.passportDetail?.civilIdNo ?? "";
        enteredCountryDateController.text =
            profileModel?.profileData?.passportDetail?.enteredCountryDate ?? "";
      }
    }
    update();
  }
}
