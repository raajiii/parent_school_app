import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../enums/enum_navigation.dart';
import '../../model/fine_list_model.dart';
import '../../services/base_client.dart';
import '../../view/screens/storage.dart';

class FineListController extends GetxController{
  RxBool showDetails = false.obs;
  ScrollController scrollController = ScrollController();
  int _pageNo = 1;
  final isLoading = true.obs;
  final loadingState = FineListLoadingState(loadingType: LoadingType.stable).obs;
  List<FineListData> finalList = <FineListData>[].obs;
  List<FineListData> fineListData = [];

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
    List<FineListData> listOfData = [];
    listOfData = await fetchData(url: "${"ApiHelper.libraryFineList"}student_id=${LocalStorage.getValue('studentId')}&page=$_pageNo");
    finalList.clear();
    finalList.assignAll(listOfData);
    isLoading.value = false;
  }

  void _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      loadingState.value = FineListLoadingState(loadingType: LoadingType.loading);
      try {
        List<FineListData> listOfData = [];
        await Future.delayed(const Duration(seconds: 5));
        listOfData = await fetchData(url: "${"ApiHelper.libraryFineList"}student_id=${LocalStorage.getValue('studentId')}&page=${++_pageNo}");
        if (listOfData.isEmpty) {
          loadingState.value = FineListLoadingState(
              loadingType: LoadingType.completed,
              completed: "there is no data");
        } else {
          finalList.addAll(listOfData);
          loadingState.value = FineListLoadingState(loadingType: LoadingType.loaded);
        }
      } catch (err) {
        loadingState.value =
            FineListLoadingState(loadingType: LoadingType.error, error: err.toString());
      }
    }
  }

  Future<List<FineListData>> fetchData({String? url}) async {
    fineListData = [];
    try {
      final result = await BaseService().getData(url??"");
      if (result != null) {
        if (result.statusCode == 200) {
          FineListModel fineListModel = FineListModel.fromJson(result.data);
          fineListData = fineListModel.data!;

        }
      }
    } catch (e) {
      print('Fetch News / Circular / Event  $e');
    }
    update();
    return fineListData;
  }


}