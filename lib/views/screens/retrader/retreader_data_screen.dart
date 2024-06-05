import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/routes_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/retrader_viewmodels/retreader_view_data_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_search_bar.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_retrader_data_card.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class RetreaderDataScreen extends StatelessWidget {
   RetreaderDataScreen({super.key});
    final StringConstants stringConstants=StringConstants();


  @override
  Widget build(BuildContext context) {
    return BaseView<RetreaderViewDataViewmodel>(
      onModelReady: (viewModel) async {
        await viewModel.getRetreaderData();
      },
      viewModel: RetreaderViewDataViewmodel(),
      builder: (context, viewModel, child) {
        return CustomScaffold(
          resizeToBottomInset: true,
          isLoading: viewModel.state == ViewState.busy,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(
                (viewModel.searchController.text.isNotEmpty ||
                        viewModel.isSearchExpanded == true)
                    ? 146
                    : 125),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonAppBar(
                    isIconBar: true,
                    showNotificationIcon: false,
                    image: ImageConstants().avatar,
                    name: stringConstants.name,
                    designation: stringConstants.userType,
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
                      hintText: stringConstants.searchHere,
                      onChanged: (value) {
                        viewModel.isSearchExpanded = true;
                        viewModel.searchRetreader(value);

                        if (viewModel.searchController.text.isEmpty) {
                          viewModel.getUpdatedList();
                        }
                      },
                      title: stringConstants.retreadedData,
                      onSuffixTap: () {
                        if (viewModel.searchController.text.isEmpty) {
                          viewModel.isSearchExpanded =
                              !viewModel.isSearchExpanded;
                          viewModel.getUpdatedList();
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
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                                child: CommonRetraderDataCard(
                                  isRetraderContainer: true,
                                  name: viewModel
                                          .data?[index].wasteTyreSupplierName ??
                                      "",
                                  contactDetails:
                                      viewModel.data?[index].contactDetails,
                                  address: viewModel
                                      .data?[index].addressOfWasteTyreSupplier,
                                  gstNumber: viewModel.data?[index].gstNumber,
                                  typeOfRaw:
                                      viewModel.data?[index].typeOfRawMaterial,
                                  total: viewModel
                                      .data?[index].quantityProcessed
                                      .toString(),
                                  date: viewModel.data?[index].retreadedDate,
                                  year: viewModel.data?[index].financialYear,
                                ),
                              ),
                            ),
                          ),
                  )
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
                      context, AppRoutes.retreadedAddDataScreenRoute);
                },
                label: stringConstants.addRetreadedDataButton,
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
