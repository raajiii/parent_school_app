import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/colors.dart';
import '../../../controllers/payment_controller/fee_payment_controller.dart';
import '../../../themes/app_styles.dart';
import '../../widgets/common_widgets.dart';

class FeePaymentScreen extends StatelessWidget {
  const FeePaymentScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeePaymentController>(
      init: FeePaymentController(),
        builder: (feePaymentController){
        return _buildBody(feePaymentController, context);
        });
  }

  Widget _buildBody(FeePaymentController feePaymentController,BuildContext context){
    return Scaffold(
      appBar: smsAppbar("Fee Payment"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              color: AppColors.cornflowerBlueColor,
              child:  buildFeeTextWidget(feePaymentController,context,"Total Fee",feePaymentController.feeModel?.feeData!.total??""),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2.15,
                  color: AppColors.cornflowerBlueColor,
                  child: buildFeeTextWidget(feePaymentController,context,"Total Fee Paid",feePaymentController.feeModel?.feeData!.paid??""),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2.15,
                  color: AppColors.cornflowerBlueColor,
                  child: buildFeeTextWidget(feePaymentController,context,"Total Fee Pending",feePaymentController.feeModel?.feeData!.pending??""),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Column buildFeeTextWidget(FeePaymentController feePaymentController,BuildContext context,String title,String value) {
    return Column(
      children: [
         Padding(
          padding:  const EdgeInsets.only(top: 10.0),
          child: Text(title,style: AppStyles.normal.copyWith(color: AppColors.whiteColor,fontSize:14),),),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              const Icon(
                Icons.currency_rupee,
                color: AppColors.whiteColor
              ),
              Text(value,style: AppStyles.normal.copyWith(color: AppColors.whiteColor,fontSize: 20),),
            ],
          ),
        ),
      ],
    );
  }
}

