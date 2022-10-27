
import 'package:raji_parent_school_app/model/voiceOverallModel.dart';

import '../enums/enum_navigation.dart';

class CustomVoiceOverallModel{
  String? date;
  int? flag;
  VoiceOverallData? voiceOverallData;

  CustomVoiceOverallModel(this.date, this.flag, this.voiceOverallData);

}


class CustomVoiceLoadingState {
  LoadingType? loadingType;
  String? error;
  String? completed;

  CustomVoiceLoadingState({required this.loadingType, this.error, this.completed});
}
