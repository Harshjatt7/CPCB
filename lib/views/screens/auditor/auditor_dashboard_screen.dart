import 'package:cpcb_tyre/viewmodels/auditor/auditor_list_view_model.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_type_badge.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../constants/image_constants.dart';
import '../../widgets/app_components/auditor_bottom_sheet.dart';
import '../../widgets/app_components/common_search_bar.dart';
import '../../widgets/components/common_appbar.dart';
import '../../widgets/components/common_button_widget.dart';

class AuditorDashboardScreen extends StatelessWidget {
  const AuditorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<AuditorListViewModel>(
        onModelReady: (viewModel) {},
        viewModel: AuditorListViewModel(),
        builder: (context, viewModel, child) {
          return CustomScaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                  (viewModel.searchController.text.isNotEmpty ||
                          viewModel.isSearchExpanded == true)
                      ? 146
                      : 125),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        color: viewModel.appColor.black10,
                      ))),
                      child: CommonSearchBarWidget(
                        title: "Audit List",
                        isSearchExpanded: viewModel.isSearchExpanded,
                        controller: viewModel.searchController,
                        hintText: viewModel.stringConstants.searchHere,
                        onChanged: (value) {
                          viewModel.isSearchExpanded = true;
                          // viewModel.searchRetreader(value);

                          if (viewModel.searchController.text.isEmpty) {
                            // viewModel.getUpdatedList();
                          }
                        },
                        onSuffixTap: () {
                          if (viewModel.searchController.text.isEmpty) {
                            viewModel.isSearchExpanded =
                                !viewModel.isSearchExpanded;
                            // viewModel.getUpdatedList();
                          } else {
                            viewModel.isSearchExpanded = false;
                            // viewModel.getUpdatedList();
                          }
                          //TODO: Remove this auditor bottom sheetlater
                          showBottomSheet(
                            context: context,
                            builder: (ctx) {
                              return AuditorBottomSheet();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: const CommonSingleChildScrollView(),
          );
        });
  }
}
