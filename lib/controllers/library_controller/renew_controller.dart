import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../enums/enum_navigation.dart';
import '../../model/renew_list_model.dart';
import '../../services/base_client.dart';
import '../../view/screens/storage.dart';

class RenewController extends GetxController{
  RxBool showDetails = false.obs;
  ScrollController scrollController = ScrollController();
  int _pageNo = 1;
  final isLoading = true.obs;
  final loadingState = RenewListLoadingState(loadingType: LoadingType.stable).obs;
  List<RenewListData> finalList = <RenewListData>[].obs;
  List<RenewListData> fineListData = [];

   void checkView(){
    showDetails.value = !showDetails.value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _getData();
    scrollController.addListener(_scrollListener);
  }

  void _getData() async {
    List<RenewListData> listOfData = [];
    listOfData = await fetchData(url: "${"ApiHelper.libraryRenewList"}student_id=${LocalStorage.getValue('studentId')}&page=$_pageNo");
    finalList.clear();
    finalList.assignAll(listOfData);
    isLoading.value = false;
  }

  void _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      loadingState.value = RenewListLoadingState(loadingType: LoadingType.loading);
      try {
        List<RenewListData> listOfData = [];
        await Future.delayed(const Duration(seconds: 5));
        listOfData = await fetchData(url: "${"ApiHelper.libraryRenewList"}student_id=${LocalStorage.getValue('studentId')}&page=${++_pageNo}");
        if (listOfData.isEmpty) {
          loadingState.value = RenewListLoadingState(
              loadingType: LoadingType.completed,
              completed: "there is no data");
        } else {
          finalList.addAll(listOfData);
          loadingState.value = RenewListLoadingState(loadingType: LoadingType.loaded);
        }
      } catch (err) {
        loadingState.value =
            RenewListLoadingState(loadingType: LoadingType.error, error: err.toString());
      }
    }
  }

  Future<List<RenewListData>> fetchData({String? url}) async {
    fineListData = [];
    try {
      final result = await BaseService().getData(url??"");
      if (result != null) {
        if (result.statusCode == 200) {
          RenewListModel renewListModel = RenewListModel.fromJson(result.data);
          fineListData = renewListModel.data!;

        }
      }
    } catch (e) {
      print('Fetch News / Circular / Event  $e');
    }
    update();
    return fineListData;
  }


}