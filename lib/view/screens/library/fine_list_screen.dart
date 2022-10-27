import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/colors.dart';
import '../../../const/contsants.dart';
import '../../../controllers/library_controller/fine_list_controller.dart';
import '../../../enums/enum_navigation.dart';
import '../../../themes/app_styles.dart';
import '../../widgets/common_widgets.dart';

class FineListScreen extends GetView<FineListController> {
  const FineListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: smsAppbar("Fine List"),
      body:Obx(() {
        final loadingType = controller.loadingState.value.loadingType;
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (controller.finalList.isEmpty) {
          return const Center(child: Text("No Data"));
        }
        return GetBuilder<FineListController>(
          builder: (fineList) {
            return ListView(
              controller: controller.scrollController,
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: loadingType == LoadingType.loading ||
                        loadingType == LoadingType.error ||
                        loadingType == LoadingType.completed
                        ? controller.finalList.length + 1
                        : controller.finalList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final isLastItem = index == controller.finalList.length;

                      if (isLastItem && loadingType == LoadingType.loading) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      } else if (isLastItem && loadingType == LoadingType.error) {
                        return Text(controller.loadingState.value.error.toString());
                      } else if (isLastItem && loadingType == LoadingType.completed) {
                        return Text(
                            controller.loadingState.value.completed.toString());
                      } else {
                        return _buildBody(controller, context,index);
                      }
                    },
                    separatorBuilder: (context, index) => Container(),
                  ),
                )
              ],
            );
          }
        );
      })
    );






      // GetBuilder<FineListController>(
      //   init: FineListController(),
      //   builder: (fineListController){
      //     return _buildBody(fineListController,context);
      //   });
  }

  Widget _buildBody(FineListController fineListController,BuildContext context,int index){
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return  SizedBox(
        height: height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10,right: 5,left: 5),
              child: SizedBox(
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            controller.checkView();
                            print("${controller.showDetails}");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 10.0,bottom: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${controller.finalList[index].bookName}",
                                      style: AppStyles.NunitoExtrabold.copyWith(
                                          fontSize: 15
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Academic Year : ${controller.finalList[index].academic}",
                                      style: AppStyles.NunitoRegular.copyWith(
                                          fontSize: 13
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Library Code : ${controller.finalList[index].code}",
                                      style: AppStyles.NunitoRegular.copyWith(
                                          fontSize: 13
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 10.0,bottom: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${Constants.RUPEESYMBOOL} ${controller.finalList[index].fineAmount}",
                                      style: AppStyles.NunitoExtrabold.copyWith(
                                        fontSize: 15,
                                        color: AppColors.indianRedColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${controller.finalList[index].fineStatus}",
                                      style: AppStyles.NunitoRegular.copyWith(
                                          fontSize: 11
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Visibility(
                          visible: controller.showDetails.value?true:false,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 10.0,bottom: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Due Details",
                                  style: AppStyles.NunitoExtrabold.copyWith(
                                      fontSize: 10,
                                      color: Colors.black45
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Divider(
                                  color: Colors.black12,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total fine Days",
                                      style: AppStyles.NunitoRegular.copyWith(
                                          fontSize: 13
                                      ),
                                    ),
                                    Text(
                                      "${fineListController.finalList[index].totalFineDays??0}",
                                      style: AppStyles.NunitoRegular.copyWith(
                                          fontSize: 13
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Single Day Fine",
                                      style: AppStyles.NunitoRegular.copyWith(
                                          fontSize: 13
                                      ),
                                    ),
                                    Text(
                                      "${Constants.RUPEESYMBOOL} ${fineListController.finalList[index].singleDayFine??0}",
                                      style: AppStyles.NunitoRegular.copyWith(
                                          fontSize: 13
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Fine Amount",
                                      style: AppStyles.NunitoRegular.copyWith(
                                          fontSize: 13
                                      ),
                                    ),
                                    Text(
                                      "${Constants.RUPEESYMBOOL} ${fineListController.finalList[index].fineAmount??0}",
                                      style: AppStyles.NunitoRegular.copyWith(
                                          fontSize: 13
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Lost Book Amount",
                                      style: AppStyles.NunitoRegular.copyWith(
                                          fontSize: 13
                                      ),
                                    ),
                                    Text(
                                      "${Constants.RUPEESYMBOOL} ${fineListController.finalList[index].lostBookAmount??0}",
                                      style: AppStyles.NunitoRegular.copyWith(
                                          fontSize: 13
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Discount",
                                      style: AppStyles.NunitoRegular.copyWith(
                                          fontSize: 13
                                      ),
                                    ),
                                    Text(
                                      fineListController.finalList[index].discount!=null?"${Constants.RUPEESYMBOOL} ${fineListController.finalList[index].discount}":"",
                                      style: AppStyles.NunitoRegular.copyWith(
                                          fontSize: 13
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Divider(
                                  color: Colors.black12,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total fine Days",
                                      style: AppStyles.NunitoRegular.copyWith(
                                          fontSize: 13
                                      ),
                                    ),
                                    Text(
                                      "${Constants.RUPEESYMBOOL} ${fineListController.finalList[index].totalFineAmount}",
                                      style: AppStyles.NunitoRegular.copyWith(
                                          fontSize: 13
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ),
            ),
          ],
        )
    );
  }
}
