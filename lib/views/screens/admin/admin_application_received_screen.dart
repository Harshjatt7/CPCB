import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/admin/admin_application_view_model.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_admin_application_card.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_search_bar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import '../../../constants/enums/state_enums.dart';
import '../../../constants/message_constant.dart';
import '../../../constants/string_constant.dart';
import '../../widgets/components/common_text_widget.dart';

class AdminApplicationReceivedScreen extends StatelessWidget {
  final String? userType;
  const AdminApplicationReceivedScreen({super.key, this.userType});

  @override
  Widget build(BuildContext context) {
    return BaseView<AdminApplicationViewModel>(
      onModelReady: (viewModel) async {
        await viewModel.getApplicationData(userType ?? "");
      },
      viewModel: AdminApplicationViewModel(),
      builder: (context, viewModel, child) {
        return CustomScaffold(
          isLoading: viewModel.state == ViewState.busy,
          appBar: buildAppBar(viewModel, context),
          body: buildBody(context, viewModel),
        );
      },
    );
  }

  Widget buildBody(BuildContext context, AdminApplicationViewModel viewModel) {
    return NotificationListener<ScrollNotification>(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: (viewModel.data?.length ?? 0) == 0
                    ? Center(
                        child: CommonTextWidget(
                            MessageConstant().noMatchingResultsFound))
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List<Widget>.generate(
                            viewModel.data?.length ?? 0, (index) {
                          final applicationData = viewModel.data?[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: CommonAdminApplicationCard(
                              applicationStatus: applicationData?.status,
                              applicationTitle: applicationData?.companyName,
                              markedTo: applicationData?.markedTo,
                              lastMarked: applicationData?.lastMarked,
                              date: HelperFunctions().getFormattedDate(date: applicationData?.lastReceived),
                            ),
                          );
                        }),
                      )),
          ],
        ),
      ),
    );
  }

  PreferredSize buildAppBar(AdminApplicationViewModel viewModel, BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
          (viewModel.searchController.text.isNotEmpty ||
                  viewModel.isSearchExpanded == true)
              ? 135
              : 120),
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
                onBackButtonTap: () {
                  Navigator.pop(context);
                },
                isBackButton: true,
                isSearchExpanded: viewModel.isSearchExpanded,
                controller: viewModel.searchController,
                hintText: StringConstants().searchHere,
                onChanged: (value) async {
                  viewModel.isSearchExpanded = true;
                  // viewModel.searchRetreader(value);

                  if (viewModel.searchController.text.isEmpty) {
                    // viewModel.getUpdatedList();
                  }
                },
                title: StringConstants().applicationReceived,
                onSuffixTap: () {
                  if (viewModel.searchController.text.isEmpty) {
                    viewModel.isSearchExpanded = !viewModel.isSearchExpanded;
                    viewModel.updateUI();
                    // viewModel.getUpdatedList();
                  } else {
                    viewModel.isSearchExpanded = false;
                    viewModel.updateUI();
                    // viewModel.getUpdatedList();
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
