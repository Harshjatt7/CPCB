import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/routes_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/responsive_helper.dart';
import 'package:cpcb_tyre/viewmodels/retrader_viewmodels/retreader_view_data_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/retrader_common_components/common_retrader_data_card.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class RetreaderDataScreen extends StatelessWidget {
  const RetreaderDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<RetreaderViewDataViewmodel>(
      onModelReady: (viewModel) async {
        await viewModel.getRetreaderData();
      },
      viewModel: RetreaderViewDataViewmodel(),
      builder: (context, viewModel, child) {
        return CustomScaffold(
          isLoading: viewModel.state == ViewState.busy,
          appBar: CommonAppBar(
            showNotificationIcon: true,
            image: ImageConstants().avatar,
            name: StringConstants().name,
            designation: StringConstants().userType,
          ),
          body: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification &&
                  notification.metrics.extentAfter == 0) {
                if ((viewModel.retreaderResponseModel?.data?.meta?.lastPage ??
                        0) >=
                    viewModel.page) {
                  viewModel.page++;
                  viewModel.loadMoreData();
                }
              }
              return false;
            },
            child: CommonSingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: Responsive().screenWidth(context),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                              color: AppColor().black10,
                            ),
                            bottom: BorderSide(
                              color: AppColor().black10,
                            ))),
                    child: CommonTextWidget(
                      StringConstants().retreadedData,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Column(
                        children: List<Widget>.generate(
                          viewModel.data?.length ?? 0,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: CommonRetraderDataCard(
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
                              total: viewModel.data?[index].quantityProcessed
                                  .toString(),
                              date: viewModel.data?[index].retreadedDate,
                              year: viewModel.data?[index].financialYear,
                            ),
                          ),
                        ),
                      ),
                      if (viewModel.state == ViewState.busy)
                        Center(
                            child: viewModel.state == ViewState.busy
                                ? CircularProgressIndicator(
                                    color: AppColor().black,
                                  )
                                : const SizedBox()),
                      const SizedBox(
                        height: 16,
                      ),
                    ]),
                  ),
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
                label: StringConstants().addRetreadedDataButton,
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
