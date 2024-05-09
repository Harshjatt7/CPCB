import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/producer_viewmodels/dashboard_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_note.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_producer_environment_tile.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_producer_erp_tile.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_producer_list_tile.dart';
import 'package:cpcb_tyre/views/widgets/app_components/producer_annual_return_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardViewModel>(
        onModelReady: (p0) {},
        viewModel: DashboardViewModel(),
        builder: (context, model, child) {
          return CustomScaffold(
              appBar: CommonAppBar(
                isProfileBar: true,
                image: ImageConstants().avatar,
                name: 'Vibhor Singh',
                designation: 'Producer',
              ),
              body: CommonSingleChildScrollView(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: AppColor().dashBoardCardBg,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                color: AppColor().dashBoardCardBorder,
                                width: 1,
                              )),
                          child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: 6,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return const Padding(
                                    padding: EdgeInsets.only(bottom: 12),
                                    child: ProducerListTile(
                                        title: 'User Type',
                                        subtitle: 'Producer'),
                                  );
                                },
                              ),
                              CommonNote(
                                  note:
                                      MessageConstant().producerDashBoardNote),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: CommonButtonWidget(
                                  label: 'Download Application',
                                  color: AppColor().darkGreen18632E,
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(color: AppColor().white),
                                ),
                              ),
                              CommonButtonWidget(
                                label: 'Download Payment Recipt',
                                color: AppColor().white,
                                borderColor: AppColor().darkGreen18632E,
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        color: AppColor().darkGreen18632E),
                              )
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: CommonTextWidget(
                          'EPR Compliance',
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: AppColor().black1A1A1A),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ProducerErpTile(
                              image: ImageConstants().contactPage,
                              title: 'Credits Received ',
                              subTitle: '34,734',
                            ),
                          );
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: ProducerAnnualReturnWidget(
                            title: 'Annual Returns',
                            date: '24 Jan 2024',
                            status: 'Delayed',
                            fillingDate: '12 Jan 2024'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: AppColor().blackDisabledButton),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16),
                                child: CommonTextWidget(
                                  'Environment Compensation',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                              Divider(
                                color: AppColor().blackDisabledButton,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8, bottom: 8),
                                                child: ProducerEnvironmentTile(
                                                    title: 'Date of EC',
                                                    subtitle: '24 Jan 2024',
                                                    image: ImageConstants()
                                                        .calendar),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8, right: 8),
                                                child: ProducerEnvironmentTile(
                                                    title: 'Type',
                                                    subtitle: 'Lorem Ipsum',
                                                    image: ImageConstants()
                                                        .infoEnv),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, bottom: 8),
                                                child: ProducerEnvironmentTile(
                                                    title: 'Current Status',
                                                    subtitle: 'Paid',
                                                    subtitleColor: AppColor()
                                                        .environmentTileSubTitle,
                                                    image: ImageConstants()
                                                        .infoEnv),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, top: 8),
                                                child: ProducerEnvironmentTile(
                                                    title: 'Amount',
                                                    subtitle: '5234',
                                                    image: ImageConstants()
                                                        .dollar),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16, bottom: 10),
                                        child: CommonTextWidget(
                                          'Descripsion',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  color: AppColor()
                                                      .environmentDesc),
                                        ),
                                      ),
                                    ),
                                    CommonTextWidget(
                                      MessageConstant().environmentText,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    )
                                  ],
                                ),
                              )
                            ]),
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}
