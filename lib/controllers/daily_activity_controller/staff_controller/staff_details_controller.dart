import 'package:get/get.dart';

import '../../../model/staff_model.dart';
import '../../../services/base_client.dart';
import '../../../view/screens/storage.dart';

class StaffDetailsController extends GetxController {
  StaffModel? staffModel;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }

  Future getData() async {
    try {
      final result = await BaseService().getData("${"ApiHelper.staffUrl"}student_id=${LocalStorage.getValue("studentId")}");
      if (result != null) {
        if (result.statusCode == 200) {
          staffModel = StaffModel.fromJson(result.data);
        }
      }
    } catch (e) {
      print("Staff Details $e");

    } finally {

    }
    update();
  }


}
