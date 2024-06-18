import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_search_bar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import '../../../theme/app_color.dart';
import '../../../viewmodels/custom/custom_dashboard_view_model.dart';
import '../../widgets/app_components/common_custom_listing_card.dart';
import '../../widgets/components/common_single_child_scrollview.dart';

class CustomDashboardScreen extends StatelessWidget {
  const CustomDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<CustomDashboardViewModel>(
      onModelReady: (viewModel) async {
        await viewModel.getCustomData();
      },
      viewModel: CustomDashboardViewModel(),
      builder: (context, viewModel, child) {
        return CustomScaffold(
          isLoading: viewModel.state == ViewState.busy,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(
                (viewModel.isSearchExpanded == true) ? 175 : 155),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonAppBar(
                    isIconBar: true,
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
                        viewModel.searchCustom(value);
                        if (viewModel.searchController.text.isEmpty) {
                          viewModel.getUpdatedList();
                        }
                      },
                      title: viewModel.stringConstants.dashboard,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: CommonTextWidget(
                      viewModel.stringConstants.producerListing,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: buildBody(context, viewModel),
        );
      },
    );
  }

  Widget buildBody(BuildContext context, CustomDashboardViewModel viewModel) {
    return NotificationListener<ScrollNotification>(
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
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List<Widget>.generate(
                        viewModel.customData?.length ?? 0, (index) {
                      final applicationData = viewModel.customData?[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonCustomListingCard(
                          companyName: applicationData?.name,
                          email: applicationData?.email,
                          contactNumber: applicationData?.mobileNumber,
                          state: applicationData?.stateName,
                          onMenuTap: () {
                            //TODO Remove Later
                            viewModel.filterBottomSheet(context);
                            // viewModel.downloadCertificate(
                            //     context, applicationData?.id ?? '');
                          },
                        ),
                      );
                    }),
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
    );
  }
}
