import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/routes_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/models/response/retreader/procurement_response_model.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/retrader_viewmodels/procurement_view_data_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_search_bar.dart';
import 'package:cpcb_tyre/views/widgets/app_components/retrader_common_components/common_retrader_data_card.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class ProcurementDataScreen extends StatelessWidget {
  const ProcurementDataScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseView<ProcurementViewDataViewModel>(
      onModelReady: (viewmodel) {
        viewmodel.getProcurementData();
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
                    name: StringConstants().name,
                    designation: StringConstants().userType,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: AppColor().black10,
                    ))),
                    child: CommonSearchBarWidget(
                      isSearchExpanded: viewModel.isSearchExpanded,
                      controller: viewModel.searchController,
                      hintText: StringConstants().searchHere,
                      onChanged: (value) {
                        viewModel.isSearchExpanded = true;
                        viewModel.searchProcurement(value);
                        if (viewModel.searchController.text.isEmpty) {
                          viewModel.getUpdatedList();
                        }
                      },
                      title: StringConstants().procurementData,
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
            child: Column(
              children: [
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: (viewModel.data?.length ?? 0) == 0
                        ? Center(
                            child: CommonTextWidget(
                                MessageConstant().noMatchingResultsFound))
                        : null),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const PageScrollPhysics(),
                          itemCount: viewModel.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            ProcurementAddData procurementData =
                                viewModel.data?[index] ?? ProcurementAddData();
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: CommonRetraderDataCard(
                                name: procurementData.sellerName ?? "",
                                contactDetails: procurementData.sellerMobile,
                                address: procurementData.sellerAddress,
                                invoiceNumber: procurementData.invoiceNumber,
                                gstNumber: procurementData.sellerGstNo,
                                typeOfRaw: procurementData.rawMaterial,
                                total: '${procurementData.purchasedQuantity}',
                                date: '${procurementData.purchasedDate}',
                                year: '${procurementData.financeYear}',
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CommonButtonWidget(
                        label: StringConstants().addProcurementButton,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRoutes.procurementAddDataScreenRoute);
                        },
                        color: AppColor().darkGreen,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: AppColor().white),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
