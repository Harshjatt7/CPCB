import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/routes_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/retreader/procurement_view_data_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_search_bar.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_retrader_data_card.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class ProcurementDataScreen extends StatelessWidget {
  final AppColor appColor = AppColor();
  ProcurementDataScreen({super.key});

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
                      color: appColor.black10,
                    ))),
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
            child: CommonSingleChildScrollView(
              controller: viewModel.scrollController,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: (viewModel.data?.isEmpty ?? true && viewModel.state == ViewState.idle)
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
                                    child: CommonRetraderDataCard(
                                      name: viewModel.data?[index].sellerName ??
                                          "NA",
                                      contactDetails:
                                          viewModel.data?[index].sellerMobile,
                                      address:
                                          viewModel.data?[index].sellerAddress,
                                      invoiceNumber:
                                          viewModel.data?[index].invoiceNumber,
                                      gstNumber:
                                          viewModel.data?[index].sellerGstNo,
                                      typeOfRaw:
                                          viewModel.data?[index].rawMaterial,
                                      total:
                                          '${viewModel.data?[index].purchasedQuantity}',
                                      date:
                                          '${viewModel.data?[index].purchasedDate}',
                                      year:
                                          '${viewModel.data?[index].financeYear}',
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      if (viewModel.state == ViewState.parallelBusy)
                        const Positioned(
                          bottom: 15,
                          left: 16,
                          right: 16,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                    ],
                  ),
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
                      context, AppRoutes.procurementAddDataScreenRoute);
                },
                label: viewModel.stringConstants.addProcurement,
                color: appColor.darkGreen,
                labelStyle: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: appColor.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
