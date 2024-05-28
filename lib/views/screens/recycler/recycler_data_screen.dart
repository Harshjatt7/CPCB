import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/routes_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/retrader_common_components/common_retrader_data_card.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../constants/message_constant.dart';
import '../../../viewmodels/recycler/view_recycler_data_viewmodel.dart';
import '../../widgets/app_components/common_search_bar.dart';
import '../../widgets/components/common_text_widget.dart';

class RecyclerDataScreen extends StatelessWidget {
  const RecyclerDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<RecyclerDataViewModel>(
      onModelReady: (viewmodel) async {
        await viewmodel.getRecyclerData();
      },
      viewModel: RecyclerDataViewModel(),
      builder: (context, viewModel, child) {
        return viewRecyclerDataBodySection(viewModel, context);
      },
    );
  }

  CustomScaffold viewRecyclerDataBodySection(
      RecyclerDataViewModel viewModel, BuildContext context) {
    return CustomScaffold(
      isLoading: viewModel.state == ViewState.busy,
      appBar: appBarSection(viewModel),
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
            (viewModel.recyclerData ?? []).isEmpty
                ? noResultsFoundView()
                : recyclerDataList(viewModel, context),
          ],
        ),
      ),
    );
  }

  Center noResultsFoundView() {
    return Center(
        child: CommonTextWidget(MessageConstant().noMatchingResultsFound));
  }

  Expanded recyclerDataList(
      RecyclerDataViewModel viewModel, BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Expanded(
            child: ListView.builder(
              controller: viewModel.scrollController,
              shrinkWrap: true,
              physics: const PageScrollPhysics(),
              itemCount: viewModel.recyclerData?.length,
              itemBuilder: (context, index) {
                final recyclerDetails = viewModel.recyclerData?[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CommonRetraderDataCard(
                    name: recyclerDetails?.wasteTyreSupplierName ?? "",
                    contactDetails:
                        recyclerDetails?.wasteTyreSupplierContact ?? "",
                    address: recyclerDetails?.wasteTyreSupplierAddress ?? "",
                    invoiceNumber: "",
                    gstNumber: recyclerDetails?.wasteTyreSupplierGst ?? "",
                    typeOfRaw: recyclerDetails?.typeOfRecycledMaterial ?? "",
                    total: "",
                    date: recyclerDetails?.recycledDate ?? "",
                    year: recyclerDetails?.financialYear ?? "",
                  ),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: CommonButtonWidget(
              onPressed: () {
                Navigator.pushNamed(
                    context, AppRoutes.recyclerAddDataScreenRoute);
              },
              label: StringConstants().addRecyclerData,
              color: AppColor().darkGreen,
              labelStyle: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: AppColor().white),
            ),
          ),
        ]),
      ),
    );
  }

  PreferredSize appBarSection(RecyclerDataViewModel viewModel) {
    return PreferredSize(
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
                onChanged: (value) async {
                  viewModel.isSearchExpanded = true;
                  viewModel.searchRetreader(value);

                  if (viewModel.searchController.text.isEmpty) {
                    viewModel.getUpdatedList();
                  }
                },
                title: StringConstants().recyclerData,
                onSuffixTap: () {
                  if (viewModel.searchController.text.isEmpty) {
                    viewModel.isSearchExpanded = !viewModel.isSearchExpanded;
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
    );
  }
}
