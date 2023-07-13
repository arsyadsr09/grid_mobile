import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:grid_mobile/constants/enum/payment_enum.dart';
import 'package:grid_mobile/utils/formatter.dart';
import '../../helpers/helpers.dart';
import '../../localization/app_translations.dart';
import '../../redux/app_state.dart';
import '../../redux/modules/payments_state.dart';
import '../../widgets/widgets.dart';
import './payment_status_view_model.dart';

class PaymentStatusView extends PaymentStatusViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, PaymentsState>(
          converter: (store) => store.state.paymentsState,
          builder: (context, state) {
            return Stack(
              children: [
                const HeaderPage(isBackToHome: true),
                Positioned(
                  left: 20,
                  right: 20,
                  top: 90,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(4, 0),
                                  blurRadius: 12,
                                  spreadRadius: 0,
                                  color: Colors.black.withOpacity(0.1))
                            ],
                            color: ColorsCustom.white),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: ColorsCustom.green.withOpacity(0.07),
                                  borderRadius: BorderRadius.circular(40)),
                              child: Icon(Icons.check_circle_outline_rounded,
                                  color: ColorsCustom.green, size: 40),
                            ),
                            const SizedBox(height: 15),
                            CustomText(
                              "${AppTranslations.of(context)!.text("payment_success")}!",
                              color: ColorsCustom.disabled,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                            CustomText(
                              Formatters.formatCurrency(
                                  widget.type == PaymentTypeEnum.charging
                                      ? state.scannedItem?.payment?.total
                                      : state.reservation?.payment?.total),
                              color: ColorsCustom.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(height: 50),
                            listDetailPayment(
                                name: AppTranslations.of(context)!
                                    .text("ref_number"),
                                value:
                                    "${widget.type == PaymentTypeEnum.charging ? state.scannedItem?.payment!.refNumber : state.reservation?.payment!.refNumber}"),
                            listDetailPayment(
                                name: AppTranslations.of(context)!
                                    .text("payment_time"),
                                value: Formatters.formatLongMonthDateTime(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        widget.type == PaymentTypeEnum.charging
                                            ? state.scannedItem!.payment!
                                                .createdAt!
                                            : state.reservation!.payment!
                                                .createdAt!))),
                            listDetailPayment(
                                name: AppTranslations.of(context)!
                                    .text("payment_method"),
                                value:
                                    "${widget.type == PaymentTypeEnum.charging ? state.scannedItem?.payment!.paymentMethod : state.reservation?.payment!.paymentMethod}"),
                            listDetailPayment(
                                name: "Charging Point ID",
                                value:
                                    "${widget.type == PaymentTypeEnum.charging ? state.scannedItem?.data!.id : state.reservation?.chargingPointId}"),
                            if (widget.type == PaymentTypeEnum.charging)
                              listDetailPayment(
                                  name: Formatters.capitalizeFirstofEach(
                                      AppTranslations.of(context)!
                                          .text("parking_ticket")),
                                  value:
                                      "${state.scannedItem?.payment!.parkingTicket}"),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Divider(
                                height: 20,
                                color: ColorsCustom.border,
                              ),
                            ),
                            if (widget.type == PaymentTypeEnum.charging)
                              listDetailPayment(
                                  name: Formatters.capitalizeFirstofEach(
                                      AppTranslations.of(context)!
                                          .text("charging_type")),
                                  value:
                                      "${state.scannedItem?.payment!.chargingType}"),
                            listDetailPayment(
                                name: Formatters.capitalizeFirstofEach(
                                    AppTranslations.of(context)!
                                        .text("amount")),
                                value: Formatters.formatCurrency(
                                    widget.type == PaymentTypeEnum.charging
                                        ? state.scannedItem?.payment!.amount
                                        : state.reservation?.payment!.amount)),
                            listDetailPayment(
                                name: AppTranslations.of(context)!.text("ppn"),
                                value: Formatters.formatCurrency(
                                    widget.type == PaymentTypeEnum.charging
                                        ? state.scannedItem?.payment!.tax
                                        : state.reservation?.payment!.tax)),
                          ],
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(4, 0),
                                    blurRadius: 12,
                                    spreadRadius: 0,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              color: ColorsCustom.white),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color:
                                        ColorsCustom.disabled.withOpacity(0.07),
                                    borderRadius: BorderRadius.circular(24)),
                                child: Icon(Icons.help_outline_rounded,
                                    color: ColorsCustom.black, size: 24),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomText(
                                    "${AppTranslations.of(context)!.text("trouble_with_payment")}?",
                                    color: ColorsCustom.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  CustomText(
                                    "${AppTranslations.of(context)!.text("let_us_know_help_center")}!",
                                    color: ColorsCustom.disabled,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              )),
                              Icon(
                                Icons.chevron_right_rounded,
                                size: 24,
                                color: ColorsCustom.disabled,
                              )
                            ],
                          )),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(4, 0),
                                blurRadius: 12,
                                spreadRadius: 0,
                                color: Colors.black.withOpacity(0.1))
                          ],
                          color: ColorsCustom.white),
                      child: sliderStartButton(context)),
                )
              ],
            );
          }),
    );
  }

  Widget listDetailPayment({required String name, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            name,
            color: ColorsCustom.disabled,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          CustomText(
            value,
            color: ColorsCustom.black,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  Widget sliderStartButton(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: 45,
      child: CustomSliderButton(
        action: () {
          onStartCharging();
        },

        ///Put label over here
        alignLabel: Alignment.center,
        label: CustomText(
            AppTranslations.of(context)!.text("slide_to_start_charging"),
            color: ColorsCustom.white,
            fontWeight: FontWeight.w400,
            fontSize: 9),
        icon: const Center(
            child: Icon(
          Icons.offline_bolt_outlined,
          color: Colors.white,
          size: 24.0,
        )),

        ///Change All the color and size from here.
        width: screenSize.width,
        radius: 10,
        height: 30,
        shimmer: false,
        buttonColor: ColorsCustom.green,
        backgroundColor: ColorsCustom.disabled.withOpacity(0.6),
        highlightedColor: Colors.white,
        baseColor: ColorsCustom.green,
      ),
    );
  }
}
