import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/models/response/admin/admin_application_response_model.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/admin/admin_application_view_model.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_admin_application_card.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_search_bar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:cpcb_tyre/views/widgets/components/download_bottom_sheet.dart';
import 'package:flutter/material.dart';
import '../../../constants/enums/state_enums.dart';
import '../../../constants/message_constant.dart';
import '../../widgets/components/common_text_widget.dart';

class AdminApplicationReceivedScreen extends StatelessWidget {
  final String? userType;
  final HelperFunctions helperFunctions = HelperFunctions();
  AdminApplicationReceivedScreen({super.key, this.userType});

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
          viewModel.onScrollEnding(userType);
        }
        return false;
      },
      child: SingleChildScrollView(
        controller: viewModel.scrollController,
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: (viewModel.data?.length ?? 0) == 0 &&
                            viewModel.state == ViewState.idle
                        ? Center(
                            child: CommonTextWidget(
                                MessageConstant().noMatchingResultsFound))
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List<Widget>.generate(
                                viewModel.data?.length ?? 0, (index) {
                              final applicationData = viewModel.data?[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: CommonAdminApplicationCard(
                                  onMenuTap: () {
                                    showDownloadBottomSheet(
                                        context, applicationData, viewModel);
                                  },
                                  applicationStatus: applicationData?.status,
                                  applicationTitle:
                                      applicationData?.companyName,
                                  applicationNumber:
                                      "${applicationData?.applicationNumber}",
                                  markedTo: applicationData?.markedTo,
                                  lastMarked: applicationData?.lastMarked,
                                  date: helperFunctions.getFormattedDate(
                                    dtstr: applicationData?.lastReceived,
                                  ),
                                ),
                              );
                            }),
                          )),
                if (viewModel.state == ViewState.parallelBusy)
                  const Positioned(
                    bottom: 15,
                    left: 16,
                    right: 16,
                    child: Center(child: CircularProgressIndicator()),
                  ),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Future<void> showDownloadBottomSheet(
      BuildContext context,
      ApplicationResponsedData? applicationData,
      AdminApplicationViewModel viewModel) async {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      context: context,
      builder: (ctx) {
        return DownloadBottomSheet(
          onDownloadTransactionTapped: () async {
            if (ctx.mounted) {
              Navigator.pop(ctx);
            }
            await viewModel.getDownloadPaymentReceipt(
                context, applicationData?.userId ?? '');
          },
          onDownloadApplicationTapped: () async {
            if (ctx.mounted) {
              Navigator.pop(ctx);
            }
            await viewModel.getDownloadApplication(
                context, applicationData?.id ?? '');
            helperFunctions.logger(applicationData?.id ?? '');
          },
        );
      },
    );
  }

  PreferredSize buildAppBar(
      AdminApplicationViewModel viewModel, BuildContext context) {
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
              name: viewModel.stringConstants.name,
              designation: viewModel.stringConstants.userType,
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
                hintText: viewModel.stringConstants.searchHere,
                onChanged: (value) async {
                  viewModel.isSearchExpanded = true;
                  viewModel.searchRetreader(value, userType ?? "");
                  if (viewModel.searchController.text.isEmpty) {
                    viewModel.getUpdatedList();
                  }
                },
                title: viewModel.stringConstants.applicationReceived,
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
