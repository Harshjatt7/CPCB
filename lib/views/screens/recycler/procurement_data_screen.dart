import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/routes_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/retrader_viewmodels/procurement_view_data_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_search_bar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_components/recycler_procurement_container.dart';

class RecyclerProcurementDataScreen extends StatelessWidget {
  const RecyclerProcurementDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProcurementViewDataViewModel>(
      onModelReady: (viewmodel) async {
        await viewmodel.getProcurementData();
      },
      viewModel: ProcurementViewDataViewModel(),
      builder: (context, viewModel, child) {
        return CustomScaffold(
          isLoading: viewModel.state == ViewState.busy,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(
                (viewModel.isSearchExpanded == true) ? 146 : 125),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonAppBar(
                    isIconBar: true,
                    showNotificationIcon: false,
                    image: ImageConstants().avatar,
                    name: viewModel.stringConstants.name,
                    designation: viewModel.stringConstants.userType,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColor().black10,
                        ),
                      ),
                    ),
                    child: CommonSearchBarWidget(
                      isSearchExpanded: viewModel.isSearchExpanded,
                      controller: viewModel.searchController,
                      hintText: viewModel.stringConstants.searchHere,
                      onChanged: (value) {
                        viewModel.isSearchExpanded = true;
                        viewModel.searchProcurement(value);
                        if (viewModel.searchController.text.isEmpty) {
                          viewModel.getUpdatedList();
                        }
                      },
                      title: viewModel.stringConstants.procurementData,
                      onSuffixTap: () {
                        if (viewModel.searchController.text.isEmpty) {
                          viewModel.isSearchExpanded =
                              !viewModel.isSearchExpanded;
                          viewModel.getUpdatedList();
                          viewModel.updateUI();
                        } else {
                          viewModel.isSearchExpanded = false;
                          viewModel.getUpdatedList();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification &&
                  notification.metrics.extentAfter == 0) {
                viewModel.onScrollEnding();
              }
              return false;
            },
            child: SingleChildScrollView(
              controller: viewModel.scrollController,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: (viewModel.data?.length ?? 0) == 0
                          ? Center(
                              child: CommonTextWidget(
                                  MessageConstant().noMatchingResultsFound))
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: List<Widget>.generate(
                                viewModel.data?.length ?? 0,
                                (index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: RecyclerProcurementDetailsContainer(
                                    name:
                                        viewModel.data?[index].sellerName ?? "",
                                    invoiceNumber:
                                        viewModel.data?[index].invoiceNumber,
                                    typeOfRaw:
                                        viewModel.data?[index].rawMaterial,
                                    date:
                                        '${viewModel.data?[index].purchasedDate}',
                                    year:
                                        '${viewModel.data?[index].financeYear}',
                                  ),
                                ),
                              ),
                            )),
                ],
              ),
            ),
          ),
          persistentFooterButtons: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CommonButtonWidget(
                onPressed: () {
                  Navigator.pushNamed(
                      context, AppRoutes.recyclerProcurementAddDataScreenRoute);
                },
                label: viewModel.stringConstants.addProcurementButton,
                color: AppColor().darkGreen,
                labelStyle: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: AppColor().white),
              ),
            ),
          ],
        );
      },
    );
  }
}
