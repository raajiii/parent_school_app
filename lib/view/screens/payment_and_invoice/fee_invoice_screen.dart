import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raji_parent_school_app/view/screens/payment_and_invoice/invoice_screen.dart';

import '../../../const/colors.dart';
import '../../../controllers/daily_activity_controller/payment_invoice_controller/fee_invoice_controller.dart';
import '../../../themes/app_styles.dart';
import '../../widgets/common_widgets.dart';

class FeeInvoiceScreen extends StatelessWidget {
  const FeeInvoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: smsAppbar("Fee Invoice"),
      body: GetBuilder<FeeInvoiceController>(
          init: FeeInvoiceController(),
          builder: (feeInvoiceController) {
            return  feeInvoiceController.feeInvoiceModel?.data!=null?ListView.builder(
                itemCount: feeInvoiceController.feeInvoiceModel?.data!.length??0,
                shrinkWrap: true,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Get.to(InvoiceScreen());
                          if(feeInvoiceController.feeInvoiceModel?.data![index].id!=null){
                            feeInvoiceController.getInvoiceSingleData(feeInvoiceController.feeInvoiceModel?.data?[index].id??0);
                          }

                        },
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 6.0),
                                      child: Text(
                                        "${feeInvoiceController.feeInvoiceModel?.data?[index].studentName}",
                                        style: AppStyles.arimBold.copyWith(
                                            color: AppColors.blackColor,
                                            fontSize: 16),
                                      ),
                                    ),
                                    buildText("${feeInvoiceController.feeInvoiceModel?.data?[index].standardSection}"),
                                    buildText("Payment Type : ${feeInvoiceController.feeInvoiceModel?.data?[index].billPayType}"),
                                    buildText("Discount Type : ${feeInvoiceController.feeInvoiceModel?.data?[index].discountType}"),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 25.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${feeInvoiceController.feeInvoiceModel?.data?[index].total}",
                                        style: AppStyles.arimBold.copyWith(
                                            color: AppColors.indianRedColor,
                                            fontSize: 20),
                                      ),
                                      Text("Total Amount",
                                          style: AppStyles.arimBold.copyWith(
                                              color: AppColors.lytGreyColor,
                                              fontSize: 12))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )):SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: const Center(
            child: CircularProgressIndicator(),
            ),
            );;
          }),
    );
  }

  Widget buildText(String text) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Text(
        text,
        style: AppStyles.normal
            .copyWith(fontSize: 14, color: AppColors.blackColor),
      ),
    );
  }
}
