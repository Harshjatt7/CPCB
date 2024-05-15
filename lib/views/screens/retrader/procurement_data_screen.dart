import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/routes_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/models/demo/retrader_data_model.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/responsive_helper.dart';
import 'package:cpcb_tyre/viewmodels/producer_viewmodels/producer_widget_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/retrader_common_components/common_retrader_data_card.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class ProcurementDataScreen extends StatelessWidget {
  const ProcurementDataScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseView<ProducerWidgetViewModel>(
      onModelReady: (viewmodel) {
        viewmodel.wait(context);
      },
      viewModel: ProducerWidgetViewModel(),
      builder: (context, viewModel, child) {
        return CustomScaffold(
          appBar: CommonAppBar(
            isProfileBar: true,
            image: ImageConstants().avatar,
            name: "Vibhor Singh",
            designation: "Producer",
          ),
          body: Column(
            children: [
              Container(
                width: Responsive().screenWidth(context),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: AppColor().black10),
                        bottom: BorderSide(
                          color: AppColor().black10,
                        ))),
                child: CommonTextWidget(
                  StringConstants().procurementData,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const PageScrollPhysics(),
                        itemCount: retraderDataList.length,
                        itemBuilder: (context, index) {
                          final retraderDetails = retraderDataList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: CommonRetraderDataCard(
                              name: retraderDetails.name ?? "",
                              contactDetails: retraderDetails.contactDetails,
                              address: retraderDetails.address,
                              invoiceNumber: retraderDetails.invoiceNumber,
                              gstNumber: retraderDetails.gstNumber,
                              typeOfRaw: retraderDetails.typeOfRaw,
                              total: retraderDetails.total,
                              date: retraderDetails.date,
                              year: retraderDetails.date,
                            ),
                           
                          );
                        },
                      ),
                    ),
                    CommonButtonWidget(
                      label: "",
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppRoutes.addSalesDataScreenRoute);
                      },
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
          ),
        );
      },
    );
  }
}
