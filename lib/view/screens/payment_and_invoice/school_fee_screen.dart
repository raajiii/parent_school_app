import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../const/colors.dart';
import '../../../const/contsants.dart';
import '../../../controllers/payment_controller/fee_pending_controller.dart';
import '../../../model/fee_model.dart';
import '../../../themes/app_styles.dart';
import '../../widgets/common_widgets.dart';

class SchoolFeePendingScreen extends StatelessWidget {
  FeeModel? feeModel;
  double mountHeight = 100;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeePendingController>(
        init: FeePendingController(),
        builder: (feePendingController) {
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: mountHeight),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: feePendingController.feeModel!.feeData!.detail![0].fees!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0,
                                      right: 15.0,
                                      top: 10,
                                      bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 6.0),
                                            child: Text(
                                              "${feePendingController.feeModel!.feeData!.detail![0].fees![index].name}",
                                              style: AppStyles.arimBold.copyWith(
                                                  color: AppColors.darkPinkColor,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          buildText(
                                              "Total: ${Constants.RUPEESYMBOOL}${feePendingController.feeModel!.feeData!.detail![0].fees![index].total}"),
                                          buildText(
                                              "Discount: ${Constants.RUPEESYMBOOL}${feePendingController.feeModel!.feeData?.detail![0].fees![index].discount}"),
                                          buildText(
                                              "Paid: ${Constants.RUPEESYMBOOL}${feePendingController.feeModel!.feeData!.detail![0].fees![index].paid}"),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 25.0),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${Constants.RUPEESYMBOOL} ${feePendingController.feeModel!.feeData!.detail![0].fees![index].pending}",
                                              style: AppStyles.arimBold.copyWith(
                                                  color: AppColors.blackColor,
                                                  fontSize: 20),
                                            ),
                                            Text("pending",
                                                style: AppStyles.arimBold
                                                    .copyWith(
                                                    color: AppColors
                                                        .lytGreyColor,
                                                    fontSize: 12))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: feePendingController.feeModel!.feeData!.detail![0].fees![index].subFee!.length,//feePendingController.feeModel!.feeData.detail![index].fees,
                                  itemBuilder:
                                      (BuildContext context, int index1) {
                                    return InkWell(
                                      onTap: () {
                                        //feeController.checkExpanedView();
                                      },
                                      child: Card(
                                        elevation: 5,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  left: 8,
                                                  right: 8.0,
                                                  bottom: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("${feePendingController.feeModel!.feeData!.detail![0].fees![index].subFee![index1].name}",
                                                      style: AppStyles
                                                          .NunitoExtrabold
                                                          .copyWith(
                                                        fontSize: 14,
                                                        color:
                                                        AppColors.blackColor,
                                                      )),
                                                  Row(
                                                    children: [
                                                      Text(
                                                          "Pending",
                                                          style: AppStyles.arimoRegular
                                                              .copyWith(
                                                              color: AppColors
                                                                  .blackColor,
                                                              fontSize: 12)),
                                                      const SizedBox(width: 10,),
                                                      Text(
                                                          "${Constants.RUPEESYMBOOL}${feePendingController.feeModel!.feeData!.detail![0].fees![index].subFee![index1].pending}",
                                                          style: AppStyles.arimBold
                                                              .copyWith(
                                                              color: AppColors
                                                                  .indianRedColor,
                                                              fontSize: 15)),
                                                    ],
                                                  )

                                                ],
                                              ),
                                            ),
                                            /* Visibility(
                                              visible: truefeeController.expandCard
                                                  ? true
                                                  : false,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0,
                                                    right: 20.0,
                                                    top: 10.0,
                                                    bottom: 10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Due Details",
                                                      style: AppStyles
                                                              .NunitoExtrabold
                                                          .copyWith(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.black45),
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
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Total fine Days",
                                                          style: AppStyles
                                                                  .NunitoRegular
                                                              .copyWith(
                                                                  fontSize: 13),
                                                        ),
                                                        Text(
                                                          "8",
                                                          style: AppStyles
                                                                  .NunitoRegular
                                                              .copyWith(
                                                                  fontSize: 13),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Single Day Fine",
                                                          style: AppStyles
                                                                  .NunitoRegular
                                                              .copyWith(
                                                                  fontSize: 13),
                                                        ),
                                                        Text(
                                                          "${Constants.RUPEESYMBOOL} 5.00",
                                                          style: AppStyles
                                                                  .NunitoRegular
                                                              .copyWith(
                                                                  fontSize: 13),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Fine Amount",
                                                          style: AppStyles
                                                                  .NunitoRegular
                                                              .copyWith(
                                                                  fontSize: 13),
                                                        ),
                                                        Text(
                                                          "${Constants.RUPEESYMBOOL} 30.00",
                                                          style: AppStyles
                                                                  .NunitoRegular
                                                              .copyWith(
                                                                  fontSize: 13),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Lost Book Amount",
                                                          style: AppStyles
                                                                  .NunitoRegular
                                                              .copyWith(
                                                                  fontSize: 13),
                                                        ),
                                                        Text(
                                                          "${Constants.RUPEESYMBOOL} 0.00",
                                                          style: AppStyles
                                                                  .NunitoRegular
                                                              .copyWith(
                                                                  fontSize: 13),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Discount",
                                                          style: AppStyles
                                                                  .NunitoRegular
                                                              .copyWith(
                                                                  fontSize: 13),
                                                        ),
                                                        Text(
                                                          "${Constants.RUPEESYMBOOL} 0.00",
                                                          style: AppStyles
                                                                  .NunitoRegular
                                                              .copyWith(
                                                                  fontSize: 13),
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
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Total fine Days",
                                                          style: AppStyles
                                                                  .NunitoRegular
                                                              .copyWith(
                                                                  fontSize: 13),
                                                        ),
                                                        Text(
                                                          "${Constants.RUPEESYMBOOL} 30.00",
                                                          style: AppStyles
                                                                  .NunitoRegular
                                                              .copyWith(
                                                                  fontSize: 13),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),*/
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                            ],
                          );
                        }),
                  ),
                ),
              ),
              _feePendingTotalAMountCard(feePendingController)

            ],
          );
        });
  }

  Widget _feePendingTotalAMountCard(FeePendingController feePendingController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            height: mountHeight,
            child: Card(
                elevation: 10,
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 4.0, bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Total:  ${Constants.RUPEESYMBOOL}${feePendingController.feeModel!.feeData!.detail![0].total}"),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 12.0, bottom: 12),
                            child: Text(
                                "Discount : ${Constants.RUPEESYMBOOL}${feePendingController.feeModel!.feeData!.detail![0].discount}"),
                          ),
                          Text(
                              "Paid: ${Constants.RUPEESYMBOOL}${feePendingController.feeModel!.feeData!.detail![0].paid}"),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0, bottom: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            //
                            Text(
                              "${Constants.RUPEESYMBOOL}${feePendingController.feeModel!.feeData!.detail![0].pending}",
                              style: AppStyles.arimBold.copyWith(
                                  color: AppColors.darkPinkColor, fontSize: 20),
                            ),
                            Text(
                              "Total Pending",
                              style: AppStyles.normal.copyWith(
                                  color: AppColors.greyColor, fontSize: 16),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
