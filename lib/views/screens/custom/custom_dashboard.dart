import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_search_bar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import '../../../theme/app_color.dart';
import '../../../viewmodels/custom/custom_dashboard_view_model.dart';
import '../../widgets/app_components/common_custom_listing_card.dart';

class CustomDashboardScreen extends StatelessWidget {
  const CustomDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<CustomDashboardViewModel>(
      onModelReady: (viewModel) {},
      viewModel: CustomDashboardViewModel(),
      builder: (context, viewModel, child) {
        return CustomScaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(
                (viewModel.isSearchExpanded == true) ? 146 : 125),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CommonAppBar(
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
                      hintText: StringConstants().searchHere,
                      onChanged: (value) {
                        viewModel.isSearchExpanded = true;
                        // viewModel.searchProcurement(value);
                        if (viewModel.searchController.text.isEmpty) {
                          // viewModel.getUpdatedList();
                        }
                      },
                      title: StringConstants().dashboard,
                      onSuffixTap: () {
                        if (viewModel.searchController.text.isEmpty) {
                          viewModel.isSearchExpanded =
                              !viewModel.isSearchExpanded;
                          // viewModel.getUpdatedList();
                          viewModel.updateUI();
                        } else {
                          viewModel.isSearchExpanded = false;
                          // viewModel.getUpdatedList();
                        }
                      },
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CommonTextWidget(
            StringConstants().producerListing,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollEndNotification &&
                notification.metrics.extentAfter == 0) {
              // viewModel.onScrollEnding();
            }
            return false;
          },
          child: SingleChildScrollView(
            controller: viewModel.scrollController,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  // TODO: Apply API later
                  // child: (viewModel.data?.length ?? 0) == 0
                  //     ? Center(
                  //         child: CommonTextWidget(
                  //             MessageConstant().noMatchingResultsFound))
                  //     : Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: List<Widget>.generate(
                  //             viewModel.data?.length ?? 0, (index) {
                  //           final applicationData = viewModel.data?[index];
                  //           return Padding(
                  //             padding: const EdgeInsets.symmetric(vertical: 8),
                  //             child: CommonCustomListingCard(
                  //               companyName: "Producer Company Name",
                  //               email: "Lorem ipsum, ipsum, 102231",
                  //               contactNumber: "Lorem ipsum, ipsum, 102231",
                  //               state: "Delhi",
                  //              ),
                  //             ),
                  //           );
                  //         }),
                  //       )

                  // TODO: Remove these dummy strings later
                  child: CommonCustomListingCard(
                    companyName: "Producer Company Name",
                    email: "Lorem ipsum, ipsum, 102231",
                    contactNumber: "Lorem ipsum, ipsum, 102231",
                    state: "Delhi",
                    onMenuTap: () {
                      viewModel.downloadCertificate(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
