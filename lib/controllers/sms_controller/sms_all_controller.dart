import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../apihelper/api_helper.dart';
import '../../enums/enum_navigation.dart';
import '../../model/custom_model.dart';
import '../../model/sms_model.dart';
import '../../services/base_client.dart';
import '../../view/screens/storage.dart';

class SmsController extends GetxController {
  List<SmsData> todayFinalList = <SmsData>[].obs;
  List<SmsData> specificFinalList = <SmsData>[].obs;
  List<SmsData> latestFinalList = <SmsData>[].obs;
  List<SmsData> smsData = [];
  final arguments = Get.arguments;
  ScrollController scrollController = ScrollController();
  ScrollController overallScrollController = ScrollController();
  int _specificPageNo = 1;
  int _overallPageNo = 1;
  final isLoading = true.obs;
  final loadingState = LoadingState(loadingType: LoadingType.stable).obs;

  @override
  void onInit() {
    super.onInit();
    if (arguments["tag"] != null) {
      if (arguments["tag"] == "SMS") {
        _getData();
        scrollController.addListener(_scrollListener);
        overallScrollController.addListener(_latestScrollListener);
      }
    }
  }

  void _getData() async {
    List<SmsData> todayList = await fetchData(
        url:
            "${"ApiHelper.smsTodayUrl"}student_id=${LocalStorage.getValue('studentId')}");
    todayFinalList.clear();
    todayFinalList.assignAll(todayList);
    List<SmsData> specificList = await fetchData(
        url:
            "${"ApiHelper.smsSpecificUrl"}student_id=${LocalStorage.getValue('studentId')}&page=$_specificPageNo");
    specificFinalList.clear();
    specificFinalList.assignAll(specificList);
    List<SmsData> overallList = await fetchData(
        url:
            "${"ApiHelper.smsOverallUrl"}student_id=${LocalStorage.getValue('studentId')}&page=$_overallPageNo");
    latestFinalList.clear();
    latestFinalList.assignAll(overallList);
    isLoading.value = false;
  }

  void _latestScrollListener() async {
    if (overallScrollController.offset >=
            overallScrollController.position.maxScrollExtent &&
        !overallScrollController.position.outOfRange) {
      loadingState.value = LoadingState(loadingType: LoadingType.loading);
      try {
        List<SmsData> overListOfData = [];
        await Future.delayed(const Duration(seconds: 5));
        overListOfData = await fetchData(
            url:
                "${"ApiHelper.smsOverallUrl"}student_id=${LocalStorage.getValue('studentId')}&page=${++_overallPageNo}");
        if (overListOfData.isEmpty) {
          loadingState.value =
              LoadingState(loadingType: LoadingType.completed, completed: "");
        } else {
          latestFinalList.addAll(overListOfData);
          loadingState.value = LoadingState(loadingType: LoadingType.loaded);
        }
      } catch (err) {
        loadingState.value =
            LoadingState(loadingType: LoadingType.error, error: err.toString());
      }
    }
  }

  void _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      loadingState.value = LoadingState(loadingType: LoadingType.loading);
      try {
        List<SmsData> listOfData = [];
        await Future.delayed(const Duration(seconds: 5));
        listOfData = await fetchData(
            url:
                "${"ApiHelper.smsSpecificUrl"}student_id=${LocalStorage.getValue('studentId')}&page=${++_specificPageNo}");
        if (listOfData.isEmpty) {
          loadingState.value =
              LoadingState(loadingType: LoadingType.completed, completed: "");
        } else {
          specificFinalList.addAll(listOfData);
          loadingState.value = LoadingState(loadingType: LoadingType.loaded);
        }
      } catch (err) {
        loadingState.value =
            LoadingState(loadingType: LoadingType.error, error: err.toString());
      }
    }
  }

  Future<List<SmsData>> fetchData({String? url}) async {
    smsData = [];
    try {
      final result = await BaseService().getData(url ?? "");
      if (result != null) {
        if (result.statusCode == 200) {
          SmsModel smsModel = SmsModel.fromJson(result.data);
          smsData = smsModel.smsData ?? [];
        }
      }
    } catch (e) {
      print('Fetch SMS  $e');
    } finally {}
    update();
    return smsData;
  }
}
