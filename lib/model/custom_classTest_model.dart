
import '../enums/enum_navigation.dart';
import 'class_test_past_model.dart';

class CustomClassTestModel{
  String? date;
  int? flag;
  ClassTestPastSubject? classTestPastSubject;

  CustomClassTestModel(this.date, this.flag, this.classTestPastSubject);
}


class CustomClassTestLoadingState {
  LoadingType loadingType;
  String? error;
  String? completed;

  CustomClassTestLoadingState({required this.loadingType, this.error, this.completed});
}
