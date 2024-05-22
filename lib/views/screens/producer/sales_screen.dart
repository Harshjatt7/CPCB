import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/models/demo/producer_sales_data_model.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/responsive_helper.dart';
import 'package:cpcb_tyre/viewmodels/producer/sales_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_producer_sales_list.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../constants/routes_constant.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SalesViewModel>(
        onModelReady: (viewModel) {},
        viewModel: SalesViewModel(),
        builder: (context, viewModel, child) {
          return CustomScaffold(
              appBar: CommonAppBar(
                showNotificationIcon: true,
                name: StringConstants().name,
                designation: StringConstants().manager,
                image: ImageConstants().avatar,
              ),
              body: Column(
                children: [
                  Container(
                    width: Responsive().screenWidth(context),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: AppColor().black10),
                            bottom: BorderSide(
                              color: AppColor().black10,
                            ))),
                    child: CommonTextWidget(
                      StringConstants().salesDataProducerListingTitle,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const PageScrollPhysics(),
                            itemCount: producerSalesDataList.length,
                            itemBuilder: (context, index) {
                              final producerSalesDetail =
                                  producerSalesDataList[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: ProducerSalesList(
                                  producerType:
                                      producerSalesDetail.producerType ?? "",
                                  title: producerSalesDetail.title ?? "",
                                  year: producerSalesDetail.year ?? "",
                                  month: producerSalesDetail.month ?? "",
                                  count: producerSalesDetail.count ?? "",
                                  motorcycle: producerSalesDetail.motorcycle,
                                  scooter: producerSalesDetail.scooter,
                                  passengerCar:
                                      producerSalesDetail.passengerCar,
                                  bus: producerSalesDetail.bus,
                                  truck: producerSalesDetail.truck,
                                  tRear: producerSalesDetail.tRear,
                                  tcv: producerSalesDetail.tcv,
                                  other: producerSalesDetail.other,
                                ),
                              );
                            },
                          ),
                        ),
                        CommonButtonWidget(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AppRoutes.addSalesDataScreenRoute);
                          },
                          label: StringConstants().addSalesDataBtnLabel,
                          color: AppColor().darkGreen,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: AppColor().white),
                        ),
                      ]),
                    ),
                  ),
                ],
              ));
        });
  }
}
