import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raji_parent_school_app/view/screens/daily_actvities/voice/voice_overall.dart';
import 'package:raji_parent_school_app/view/screens/daily_actvities/voice/voice_specific.dart';

import '../../../../const/colors.dart';
import '../../../../controllers/daily_activity_controller/voice_controller/voice_controller.dart';
import '../../../widgets/common_widgets.dart';
import 'voice_custom.dart';

class VoiceScreen extends StatelessWidget {
  const VoiceScreen({Key? key}) : super(key: key);



  Widget _buildBody(VoiceController voiceController,BuildContext context){
    return Scaffold(
        appBar: smsAppbar("Voice"),
        body: DefaultTabController(
            length: 3, // length of tabs
            initialIndex: 0,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const TabBar(
                    labelColor: AppColors.darkPinkColor,
                    unselectedLabelColor: AppColors.greyColor,
                    indicatorColor: AppColors.darkPinkColor,
                    tabs: [
                      Tab(
                        text: 'LATEST',
                      ),
                      Tab(text: 'SPECIFIC'),
                      Tab(text: 'OVERALL'),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child:   TabBarView(children: <Widget>[
                      VoiceCustom(),
                      VoiceSpecific(),
                      VoiceOverall(),
                    ]),
                  )
                ])));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VoiceController>(
        init: VoiceController(),
        builder: (voiceController){
          return _buildBody(voiceController, context);
        });
  }
}
