import 'package:get/get.dart';

import '../../model/fee_model.dart';
import '../../services/base_client.dart';

class FeePaymentController extends GetxController{

  FeeModel? feeModel;

  void getFeePayment() async{

    try{
      final result = await BaseService().getData("ApiHelper.feePayment");
      if(result!=null&&result.statusCode==200){
        feeModel = FeeModel.fromJson(result.data);

      }

    }catch (e){


    }finally{


    }
    update();

  }




  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(const Duration(seconds: 1),(){
      getFeePayment();
    });
  }

}