import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../apihelper/api_helper.dart';
import '../../../const/colors.dart';
import '../../../enums/enum_navigation.dart';
import '../../../model/custom_model.dart';
import '../../../model/home_work_model.dart';
import '../../../model/single_subject_homework_model.dart';
import '../../../services/base_client.dart';
import '../../../view/dialogs/dialog_helper.dart';
import '../../../view/screens/daily_actvities/homework/homework_submission_screen.dart';
import '../../../view/screens/storage.dart';

class HomeworkController extends GetxController
    with GetSingleTickerProviderStateMixin {
  DateTime currentDate = DateTime.now();
  bool isExpanded = false;
  String startDate = "";
  String endDate = "";
  int currentTab = 0;
  late TabController tabController;
  List<HomeWorkData> homeworkDataList = [];
  List<HomeWorkData> finalList = <HomeWorkData>[].obs;
  final arguments = Get.arguments;
  int _pageNo = 1;
  final loadingState = LoadingState(loadingType: LoadingType.stable).obs;
  final isLoading = true.obs;
  List<FilesUploadModel> filesList = <FilesUploadModel>[].obs;
  ImagePicker picker = ImagePicker();
  XFile? image;
  TextEditingController homeworkController = TextEditingController();
  ScrollController scrollController = ScrollController();
  String selectedDate = "";
  String startingDateValue = "";
  String endingDateValue = "";
  bool isVisible = true;
  String type = "";
  bool loading = false;
  SingleSubjectData? subjectData;

  @override
  void onInit() {
    super.onInit();
    currentTab = 0;
    tabController = TabController(vsync: this, length: 3);
    isVisible = true;
    _getData();
    scrollController.addListener(_scrollListener);
    tabController.addListener(() {
      currentTab = tabController.index;
      if (currentTab == 2) {
        finalList = [];
        isVisible = false;
      } else {
        finalList = [];
        isVisible = true;
        _getData();
      }
    });
  }

  updateTabIndex(int index) {
    currentTab = index;
    update();
  }

  void expandedView(expanded) {
    isExpanded = !expanded;
    update();
  }

  removeItem(int index) {
    filesList.removeAt(index);
    update();
  }

  void _getData() async {
    if (_pageNo == 1) {
      isLoading.value = true;
    }
    finalList = [];
    List<HomeWorkData> listOfData = [];
    if (arguments["tag"] != null) {
      if (arguments["tag"] == "Homework") {
        if (currentTab == 0) {
          listOfData = await fetchData(
              url:
                  "${"ApiHelper.homeworkForTodayUrl"}student_id=${LocalStorage.getValue('studentId')}");
        } else if (currentTab == 1) {
          _pageNo = 1;
          listOfData = await fetchData(
              url:
                  "${"ApiHelper.homeworkPastUrl"}student_id=${LocalStorage.getValue('studentId')}&page=$_pageNo");
        } else {
          _pageNo = 1;
          listOfData = await fetchData(
              url:
                  "${"ApiHelper.homeworkReportUrl"}student_id=${LocalStorage.getValue('studentId')}&start_date=$startingDateValue&end_date=$endingDateValue&type=$type&page=$_pageNo");
        }
      }
      finalList.clear();
      finalList.assignAll(listOfData);
      isLoading.value = false;
    }
  }

  void _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      loadingState.value = LoadingState(loadingType: LoadingType.loading);
      try {
        List<HomeWorkData> listOfData = [];
        await Future.delayed(const Duration(seconds: 5));
        if (arguments["tag"] != null) {
          if (arguments["tag"] == "Homework") {
            if (currentTab == 1) {
              listOfData = await fetchData(
                  url:
                      "${"ApiHelper.homeworkPastUrl"}student_id=${LocalStorage.getValue('studentId')}&page=${++_pageNo}");
            }
          } else if (currentTab == 2) {
            listOfData = await fetchData(
                url:
                    "${"ApiHelper.homeworkReportUrl"}student_id=${LocalStorage.getValue('studentId')}&start_date=$startingDateValue&end_date=$endingDateValue&type=$type&page=$_pageNo");
          } else {}
        }
        if (listOfData.isEmpty) {
          loadingState.value =
              LoadingState(loadingType: LoadingType.completed, completed: "");
        } else {
          finalList.addAll(listOfData);
          loadingState.value = LoadingState(loadingType: LoadingType.loaded);
        }
      } catch (err) {
        loadingState.value =
            LoadingState(loadingType: LoadingType.error, error: err.toString());
      }
    }
  }

  Future<List<HomeWorkData>> fetchData({String? url}) async {
    homeworkDataList = [];
    try {
      final result = await BaseService().getData(url ?? "");
      if (result != null) {
        if (result.statusCode == 200) {
          HomeWorkModel homeWorkModel = HomeWorkModel.fromJson(result.data);
          homeworkDataList = homeWorkModel.homeworkData ?? [];
        } else {
          homeworkDataList = [];
        }
      }
    } catch (e) {
      print('Homework screen  $e');
    }
    update();
    return homeworkDataList;
  }

/*  Future fetchHomeworkSubject(String homeworkID) async {
    try {
      final result = await BaseService().getData("${ApiHelper.homeworkSubjectUrl}student_id=${LocalStorage.getValue("studentId")}&homework_id=");
      if (result != null) {
        if (result.statusCode == 200) {
          SingleSubjectModel subjectModel =
              SingleSubjectModel.fromJson(result.data);
          subjectData = subjectModel.subjectData;
        }
      }
    } catch (e) {
      print('Homework screen  $e');
    }
    update();
  }*/

  Future filePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path.toString());
      String filename = file.path.split('/').last;
      filesList.add(FilesUploadModel(file: file, fileName: filename));
    }
    update();
  }

  Future captureImage() async {
    image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 25);
    String filename = image!.path.split('/').last;
    filesList.add(FilesUploadModel(
        file: File(image!.path.toString()), fileName: filename));
    update();
  }

  Future sendHomeworkSubmission(
      {required String homewrkId,
      required String homewrkText,
      required List<FilesUploadModel> filesList,
      required String url}) async {
    showLoadingDialog(Get.context!);
    try {
      final result = await BaseService().uploadMultipleFiles(
          homewrkId: homewrkId,
          homewrkText: homewrkText,
          filesList: filesList,
          url: url);
      if (result != null) {
        if (result.statusCode == 200) {
          _getData();
          Get.back();
        } else {}
      }
    } catch (e) {
      print('Homework Submission Screen  $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
  }

  Future sendMultipleDays(
      String startingDate, String endingDate, String eventType) async {
    Future.delayed(const Duration(seconds: 1));
    finalList = [];
    isVisible = false;
    type = eventType;
    startingDateValue = startingDate;
    endingDateValue = endingDate;
    _getData();
    update();
  }

  updateFinalList() {
    finalList = [];
    update();
  }

  Future sendSingleDay(String eventType, String startingDate) async {
    Future.delayed(const Duration(seconds: 1));
    finalList = [];
    isVisible = false;
    type = eventType;
    startingDateValue = startingDate;
    endingDateValue = "";
    _getData();
    update();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1800),
        lastDate: DateTime(3000),
        currentDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.darkPinkColor, // <-- SEE HERE
                onPrimary: AppColors.whiteColor, // <-- SEE HERE
                surface: AppColors.blackColor,
              ),
            ),
            child: child!,
          );
        });
    if (pickedDate != null) {
      currentDate = pickedDate;
      selectedDate = currentDate.toString().split(' ')[0];
      if (arguments["tag"] == "Homework") {
        sendSingleDay("1", selectedDate);
      } else {}
      update();
    }
  }

  Future<void> dateRangeDialog(BuildContext context) async {
    DateTimeRange? result = await showDateRangePicker(
        context: context,
        firstDate: DateTime(1800, 1, 1),
        lastDate: DateTime(3000, 12, 31),
        currentDate: DateTime.now(),
        saveText: 'SAVE',
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.darkPinkColor, // <-- SEE HERE
                onPrimary: AppColors.whiteColor, // <-- SEE HERE
                surface: AppColors.blackColor,
              ),
            ),
            child: child!,
          );
        });
    if (result != null) {
      startDate = result.start.toString().split(' ')[0];
      endDate = result.end.toString().split(' ')[0];
      if (arguments["tag"] == "Homework") {
        sendMultipleDays(startDate, endDate, "2");
      } else {}
      update();
    }
  }
}
