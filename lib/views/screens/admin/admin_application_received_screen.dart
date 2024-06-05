import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/admin/admin_application_view_model.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_admin_application_card.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_search_bar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import '../../../constants/string_constant.dart';

class AdminApplicationReceivedScreen extends StatelessWidget {
  const AdminApplicationReceivedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<AdminApplicationViewModel>(
      onModelReady: (model) {},
      viewModel: AdminApplicationViewModel(),
      builder: (context, viewModel, child) {
        return CustomScaffold(
          appBar: buildAppBar(viewModel),
          body: buildBody(context),
        );
      },
    );
  }

  Widget buildBody(BuildContext context) {
    return CommonAdminApplicationCard(
      applicationName: "New Application",
      applicationNumber: "010000005354",
      applicationTitle: "2 Degrees Clicon Private Limited",
      lastMarked: "Naveen Kumar",
      markedTo: "Anand Kumar (DH)",
      total: "1048",
      date: "24/08/2023",
      year: "2023",
      onMenuTap: () {},
    );
  }

  PreferredSize buildAppBar(AdminApplicationViewModel viewModel) {
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
                onBackButtonTap: () {},
                isBackButton: true,
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
                title: StringConstants().applicationReceived,
                onSuffixTap: () {
                  if (viewModel.searchController.text.isEmpty) {
                    viewModel.isSearchExpanded = !viewModel.isSearchExpanded;
                    viewModel.updateUI();
                    // viewModel.getUpdatedList();
                  } else {
                    viewModel.isSearchExpanded = false;
                    viewModel.updateUI();
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
