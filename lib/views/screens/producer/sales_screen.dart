import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/routes_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/producer/sales_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_producer_sales_list.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_title_bar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SalesScreen extends StatelessWidget {
   SalesScreen({super.key});
  final AppColor appColor=AppColor();

  @override
  Widget build(BuildContext context) {
    return BaseView<SalesViewModel>(
      onModelReady: (viewmodel) async {
        await viewmodel.getSalesData();
      },
      viewModel: SalesViewModel(),
      builder: (context, viewModel, child) {
        return CustomScaffold(
          isLoading: viewModel.state == ViewState.busy,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(125),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonAppBar(
                    isIconBar: true,
                    showNotificationIcon: false,
                    image: ImageConstants().avatar,
                    name:viewModel.stringConstants.name,
                    designation: viewModel.stringConstants.userType,
                  ),
                  CommonTitleBar(
                      title: viewModel.stringConstants.salesDataProducerListingTitle)
                ],
              ),
            ),
          ),
          body: NotificationListener<ScrollNotification>(
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
                  Stack(
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: (viewModel.data?.length ?? 0) == 0
                              ? Center(
                                  child: CommonTextWidget(
                                      MessageConstant().noMatchingResultsFound))
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List<Widget>.generate(
                                    viewModel.data?.length ?? 0,
                                    (index) => Padding(
                                        padding:
                                            const EdgeInsets.symmetric(vertical: 8),
                                        child: ProducerSalesList(
                                          title: viewModel.data?[index]
                                                  .typeOfTyreManufacture ??
                                              '',
                                          year: viewModel
                                                  .data?[index].financialYear ??
                                              '',
                                          month: viewModel.data?[index].month ?? '',
                                          count: viewModel.data?[index].total ?? "",
                                          producerType:
                                              viewModel.data?[index].producerType ??
                                                  '',
                                          bus: viewModel.data?[index].bus,
                                          motorcycle:
                                              viewModel.data?[index].motorCycle,
                                          other: viewModel.data?[index].other,
                                          passengerCar:
                                              viewModel.data?[index].passengerCar,
                                          scooter: viewModel.data?[index].scooter,
                                          tRear: viewModel.data?[index].tRear,
                                          truck: viewModel.data?[index].truck,
                                          tcv: viewModel.data?[index].lcv,
                                        )),
                                  ),
                                )),
                    
                    if(viewModel.state == ViewState.parallelBusy)
                Positioned(
                  bottom: 15,
                  left: 16,
                  right: 16,
                  child: Center(child: CircularProgressIndicator())),
                    
                    ],
                  ),
                
               
                ],


              ),
            ),
          ),
          persistentFooterButtons: [
            Padding(
          padding: const EdgeInsets.all(0.0),
              child: CommonButtonWidget(
                onPressed: () {
                  Navigator.pushNamed(
                      context, AppRoutes.addSalesDataScreenRoute);
                },
                label: viewModel.stringConstants.addSalesDataBtnLabel,
                color: appColor.darkGreen,
                labelStyle: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: appColor.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
