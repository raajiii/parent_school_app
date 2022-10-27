import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raji_parent_school_app/view/screens/payment_and_invoice/school_fee_screen.dart';
import '../../../const/colors.dart';
import '../../../controllers/payment_controller/fee_pending_controller.dart';
import '../../widgets/common_widgets.dart';

class FeePendingScreen extends StatelessWidget {
  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeePendingController>(
        init: FeePendingController(),
        builder: (feePendingController) {
          return _buildBody(feePendingController, context);
        });
  }

  Widget _buildBody(
      FeePendingController feePendingController, BuildContext context) {
    return Scaffold(
        appBar: smsAppbar("Fee Pending"),
        body: feePendingController.feeModel?.feeData != null
            ? DefaultTabController(
                length:
                    feePendingController.feeModel?.feeData!.detail?.length ?? 0,
                // length of tabs
                initialIndex: 0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TabBar(
                        controller: _tabController,
                        labelColor: AppColors.darkPinkColor,
                        unselectedLabelColor: AppColors.greyColor,
                        indicatorColor: AppColors.darkPinkColor,
                        tabs: feePendingController.feeModel != null
                            ? feePendingController
                                    .feeModel!.feeData!.detail!.isNotEmpty
                                ? feePendingController
                                    .feeModel!.feeData!.detail!
                                    .map((e) => Tab(
                                          text: '${e.name}',
                                        ))
                                    .toList()
                                : []
                            : [],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        //
                        child: TabBarView(
                            controller: _tabController,
                            children: feePendingController.feeModel != null
                                ? feePendingController
                                    .feeModel!.feeData!.detail!
                                    .map((e) => SchoolFeePendingScreen())
                                    .toList()
                                : []),
                      )
                    ]))
            : SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ));
  }
}
