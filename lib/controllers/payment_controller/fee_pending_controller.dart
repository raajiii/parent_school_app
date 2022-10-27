import 'package:get/get.dart';

import '../../model/fee_model.dart';
import '../../services/base_client.dart';
import '../../view/screens/storage.dart';

class FeePendingController extends GetxController {
  FeeModel? feeModel;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 1), () {
    getFeePending();
    });
  }

  Future getFeePending() async {
    try {
      final result = await BaseService().getData("${"ApiHelper.feePayment"}student_id=${LocalStorage.getValue("studentId")}");
      if (result != null) {
        if (result.statusCode == 200) {
          feeModel = FeeModel.fromJson(result.data);
        }
      }
    } catch (e) {
      print("Fee Pending $e");
    } finally {

    }
    update();
  }
}
