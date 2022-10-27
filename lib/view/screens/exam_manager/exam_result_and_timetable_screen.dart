import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../const/colors.dart';
import '../../../controllers/daily_activity_controller/exam_manager_controller/exam_result_timetable_controller.dart';
import '../../widgets/common_widgets.dart';

class ExamResultScreen extends StatelessWidget {
  final String tag;

  const ExamResultScreen({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: smsAppbar(tag),
      body: GetBuilder<ExamResultAndTimeTableController>(
          init: ExamResultAndTimeTableController(),
          builder: (examResultController) {
            return examResultController.examListData!.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Exam List"),
                        ),
                        SelectExamResultDropDown(
                          examResultController: examResultController,
                        ),
                        examResultController.isLoading
                            ? Container(
                                height: Get.height * 0.5,
                                child: circularProgressIndicator()
                                    .paddingOnly(top: 20))
                            : Container(
                                // color: Colors.blueGrey,
                                width: MediaQuery.of(context).size.width,
                                child: HtmlWidget(
                                    /*examResultController.examTimeTableModel
                                        ?.examTimeTableData?.timeTable ??
                                    ""*/
                                    """ <style>table{border-collapse:collapse}.table{width:100%;max-width:100%;margin-bottom:1rem;background-color:transparent}.table-bordered,.table-bordered td,.table-bordered th{border:1px solid #e3ebf3}.bg-amber.bg-lighten-3,.btn-amber.btn-lighten-3{background-color:#ffe082!important}.table.table-xs td,.table.table-xs th{padding:.4rem 2rem}.table thead th{vertical-align:bottom;border-bottom:2px solid #e3ebf3;border-top:1px solid #e3ebf3}.table-bordered,.table-bordered td,.table-bordered th{border:1px solid #e3ebf3}.text-center{text-align:center!important}th{white-space:nowrap}.white{color:#fff!important}.bg-gradient-directional-info{background-image:-webkit-linear-gradient(45deg ,#168dee,#62bcf6);background-image:-moz-linear-gradient(#168dee,#62bcf6);background-image:-o-linear-gradient(45deg,#168dee,#62bcf6);background-image:linear-gradient(45deg ,#168dee,#62bcf6);background-repeat:repeat-x}.danger{color:#ff4961!important}.list-inline,.list-unstyled{padding-left:0;list-style:none}.bg-gradient-directional-cyan {background-image: -webkit-linear-gradient(45deg,#0097A7,#4DD0E1);background-image: -moz-linear-gradient(45deg,#0097A7,#4DD0E1);background-image: -o-linear-gradient(45deg,#0097A7,#4DD0E1);background-image: linear-gradient(45deg,#0097A7,#4DD0E1);background-repeat: repeat-x;}.text-white {color: #FFF!important;}.align-middle {vertical-align: middle!important;}.bg-blue{background-color:#2196f3!important}.bg-blue.bg-lighten-4,.btn-blue.btn-lighten-4{background-color:#bbdefb!important}.text-right {text-align: right!important;}.bg-amber {background-color: #FFC107!important;}.bg-bitbucket {background-color: #205081;}.bg-danger.bg-lighten-3, .btn-danger.btn-lighten-3 {\n                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   background-color: #FFA4B0!important;\n                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               }</style>\n<table class=\"table table-xs table-striped table-bordered zero-configuration display compact\" width=\"100%\">\n    <thead>\n    <tr class=\"bg-amber\">\n        <th class=\"text-center align-middle\" rowspan=\"1\" width=\"6%\"><b>S.No</b></th>\n        <th class=\"text-center align-middle\" rowspan=\"1\" width=\"35%\"><b>Subject</b></th>\n        <th class=\"text-center\" colspan=\"1\"><b>100 Mark</b></th>\n    </tr>\n                    </thead>\n    <tbody>\n            <tr>\n            <td class=\"text-center bg-gradient-directional-info white\">1</td>\n            <td class=\"text-center bg-gradient-directional-info white\">\n                                    Tamil\n                            </td>\n                                                                <td class=\"text-center  \" colspan=\"1\">\n                        <div class=\"col-md-10 col-lg-9\">\n                            <i class=\"fa ft-info\" aria-label=\"Absent\" md-labeled-by-tooltip=\"md-tooltip-87\">  -  </i>\n                        </div>\n                    </td>\n                                    </tr>\n            <tr>\n            <td class=\"text-center bg-gradient-directional-info white\">2</td>\n            <td class=\"text-center bg-gradient-directional-info white\">\n                                    English\n                            </td>\n                                                                <td class=\"text-center  \" colspan=\"1\">\n                        <div class=\"col-md-10 col-lg-9\">\n                            <i class=\"fa ft-info\" aria-label=\"Absent\" md-labeled-by-tooltip=\"md-tooltip-87\">  -  </i>\n                        </div>\n                    </td>\n                                    </tr>\n            <tr>\n            <td class=\"text-center bg-gradient-directional-info white\">3</td>\n            <td class=\"text-center bg-gradient-directional-info white\">\n                                    Maths\n                            </td>\n                                                                <td class=\"text-center  \" colspan=\"1\">\n                        <div class=\"col-md-10 col-lg-9\">\n                            <i class=\"fa ft-info\" aria-label=\"Absent\" md-labeled-by-tooltip=\"md-tooltip-87\">  -  </i>\n                        </div>\n                    </td>\n                                    </tr>\n            <tr>\n            <td class=\"text-center bg-gradient-directional-info white\">4</td>\n            <td class=\"text-center bg-gradient-directional-info white\">\n                                    EVS\n                            </td>\n                                                                <td class=\"text-center  \" colspan=\"1\">\n                        <div class=\"col-md-10 col-lg-9\">\n                            <i class=\"fa ft-info\" aria-label=\"Absent\" md-labeled-by-tooltip=\"md-tooltip-87\">  -  </i>\n                        </div>\n                    </td>\n                                    </tr>\n            <tr>\n            <td class=\"text-center bg-gradient-directional-info white\">5</td>\n            <td class=\"text-center bg-gradient-directional-info white\">\n                                    LSRW\n                            </td>\n                                                                <td class=\"text-center  \" colspan=\"1\">\n                        <div class=\"col-md-10 col-lg-9\">\n                            <i class=\"fa ft-info\" aria-label=\"Absent\" md-labeled-by-tooltip=\"md-tooltip-87\">  -  </i>\n                        </div>\n                    </td>\n                                    </tr>\n                </tbody>\n</table>"""

                               , renderMode: RenderMode.column,
                                  textStyle: const TextStyle(fontSize: 16),
                                  webView: true, )),
                      ],
                    ),
                  )
                : circularProgressIndicator();
          }),
    );
  }
}

class SelectExamResultDropDown extends StatelessWidget {
  final ExamResultAndTimeTableController examResultController;

  SelectExamResultDropDown({required this.examResultController});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.94,
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: examResultController.dropdownValue,
            icon: const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(Icons.arrow_drop_down),
            ),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: AppColors.blackColor, fontSize: 18),
            onChanged: (data) {
              examResultController.updateSelectedIndex(data: data!);
            },
            items: examResultController.examListData
                ?.map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                value: value.name,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    value.name.toString(),
                    style: arimoRegularTextStyle(
                        fontSize: 14, color: AppColors.blackColor),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    ]);
  }
}
