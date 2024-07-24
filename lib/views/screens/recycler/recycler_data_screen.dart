import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/routes_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../constants/message_constant.dart';
import '../../../viewmodels/recycler/view_recycler_data_viewmodel.dart';
import '../../widgets/app_components/common_search_bar.dart';
import '../../widgets/app_components/recycler_detail_container.dart';
import '../../widgets/components/common_text_widget.dart';

class RecyclerDataScreen extends StatelessWidget {
  final AppColor appColor = AppColor();
  RecyclerDataScreen({super.key});

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
        child: CommonSingleChildScrollView(
          controller: viewModel.scrollController,
          child: Column(
            children: [
              Stack(
                children: [
                  recyclerDataList(viewModel, context),
                  if (viewModel.state == ViewState.parallelBusy)
                    const Positioned(
                        bottom: 15,
                        left: 16,
                        right: 16,
                        child: Center(child: CircularProgressIndicator())),
                ],
              )
            ],
          ),
        ),
      ),
      persistentFooterButtons: [buttonSection(context, viewModel)],
    );
  }

  Center noResultsFoundView() {
    return Center(
        child: CommonTextWidget(MessageConstant().noMatchingResultsFound));
  }

  recyclerDataList(RecyclerDataViewModel viewModel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        (viewModel.recyclerData?.isEmpty ??
                true && viewModel.state == ViewState.idle)
            ? noResultsFoundView()
            : ListView.builder(
                controller: viewModel.scrollController,
                shrinkWrap: true,
                physics: const PageScrollPhysics(),
                itemCount: viewModel.recyclerData?.length ?? 0,
                itemBuilder: (context, index) {
                  final recyclerDetails = viewModel.recyclerData?[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: RecyclerDetailsContainer(
                      name: recyclerDetails?.wasteTyreSupplierName ?? "",
                      qtyProcessed: "${recyclerDetails?.processedQty ?? ""}",
                      qtyProduced: "${recyclerDetails?.producedQty ?? ""}",
                      wasteQty: "${recyclerDetails?.wasteGeneratedQty ?? ""}",
                      contactDetails:
                          recyclerDetails?.wasteTyreSupplierContact ?? "",
                      address: recyclerDetails?.wasteTyreSupplierAddress ?? "",
                      gstNumber: recyclerDetails?.wasteTyreSupplierGst ?? "",
                      typeOfRaw: recyclerDetails?.typeOfRecycledMaterial ?? "",
                      date: recyclerDetails?.recycledDate ?? "",
                      year: recyclerDetails?.financialYear ?? "",
                      // tyreSource: recyclerDetails?.tyreSource ?? "",
                    ),
                  );
                },
              ),
      ]),
    );
  }

  Widget buttonSection(BuildContext context, RecyclerDataViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: CommonButtonWidget(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.recyclerAddDataScreenRoute);
        },
        label: viewModel.stringConstants.addRecyclerData,
        color: appColor.darkGreen,
        labelStyle: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(color: appColor.white),
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
                onChanged: (value) async {
                  viewModel.isSearchExpanded = true;
                  viewModel.searchRecycler(value);

                  if (viewModel.searchController.text.isEmpty) {
                    viewModel.getUpdatedList();
                  }
                },
                title: viewModel.stringConstants.recyclerData,
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
