import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/responsive_helper.dart';
import 'package:cpcb_tyre/viewmodels/producer_viewmodels/sales_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_producer_sales_list.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SalesViewModel>(
        onModelReady: (p0) {},
        viewModel: SalesViewModel(),
        builder: (context, model, child) {
          return CustomScaffold(
              appBar: CommonAppBar(
                isProfileBar: true,
                name: "Vibhor Singh",
                designation: "Manager",
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
                            top: BorderSide(color: AppColor().appBarBorder),
                            bottom: BorderSide(
                              color: AppColor().appBarBorder,
                            ))),
                    child: CommonTextWidget(
                      'Sales data producer listing',
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
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: ProducerSalesList(
                                  title: 'BiasPly',
                                  year: '2022-2023',
                                  month: 'January',
                                  count: '19',
                                  car: '2',
                                  scooter: '4',
                                  deliveryTruck: '5',
                                  train: '1',
                                  truck: '6',
                                  tyre: '9',
                                ),
                              );
                            },
                          ),
                        ),
                        CommonButtonWidget(
                          label: 'Add sales data',
                          color: AppColor().darkGreen18632E,
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
