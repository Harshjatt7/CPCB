import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../constants/image_constants.dart';
import '../../../../viewmodels/auditor/recycler_form/recycler_procurement_view_model.dart';
import '../../../widgets/app_components/auditor_view_entries_card.dart';
import '../../../widgets/app_components/common_title_bar.dart';
import '../../../widgets/components/common_appbar.dart';

class RecyclerProcurementList extends StatelessWidget {
  const RecyclerProcurementList({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onModelReady: (viewModel) {},
      viewModel: RecyclerProcurementViewModel(),
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
                  ),
                  CommonTitleBar(title: "Procurement List"),
                ],
              ),
            ),
          ),
          body: CommonSingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: List.generate(10, (index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: AuditorViewEntriesCard(),
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}
