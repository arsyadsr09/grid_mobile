import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:grid_mobile/constants/enum/payment_enum.dart';
import 'package:grid_mobile/utils/formatter.dart';
import '../../helpers/helpers.dart';
import '../../localization/app_translations.dart';
import '../../redux/app_state.dart';
import '../../widgets/widgets.dart';
import './payment_view_model.dart';

class PaymentView extends PaymentViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (context, state) {
              return Stack(children: [
                HeaderPage(
                  title: AppTranslations.of(context)!.text("payment"),
                ),
                Positioned(
                    left: 20,
                    right: 20,
                    bottom: 0,
                    top: 90,
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              AppTranslations.of(context)!.text("summary"),
                              color: ColorsCustom.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: 15),
                            if (widget.type == PaymentTypeEnum.charging)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  rowTextInfo(
                                      label: AppTranslations.of(context)!
                                          .text("charging_amount"),
                                      value: Formatters.formatCurrency(state
                                          .paymentsState
                                          .scannedItem
                                          ?.payment
                                          ?.amount)),
                                  const SizedBox(height: 5),
                                  rowTextInfo(
                                      label:
                                          "${AppTranslations.of(context)!.text("ppn")} (10%)",
                                      value: Formatters.formatCurrency((state
                                          .paymentsState
                                          .scannedItem!
                                          .payment!
                                          .tax!)))
                                ],
                              ),
                            if (widget.type == PaymentTypeEnum.reservation)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  rowTextInfo(
                                      label: AppTranslations.of(context)!
                                          .text("reserve"),
                                      value: Formatters.formatCurrency(state
                                          .paymentsState
                                          .reservation
                                          ?.payment
                                          ?.amount)),
                                  const SizedBox(height: 5),
                                  rowTextInfo(
                                      label: AppTranslations.of(context)!
                                          .text("space_pick"),
                                      value: Formatters.formatCurrency(state
                                          .paymentsState
                                          .reservation
                                          ?.spacePickAmount)),
                                  const SizedBox(height: 5),
                                  rowTextInfo(
                                      label:
                                          "${AppTranslations.of(context)!.text("ppn")} (10%)",
                                      value: Formatters.formatCurrency(state
                                          .paymentsState
                                          .reservation!
                                          .payment!
                                          .tax!))
                                ],
                              ),
                            Divider(
                              color: ColorsCustom.border,
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  AppTranslations.of(context)!.text("total"),
                                  color: ColorsCustom.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                                CustomText(
                                  Formatters.formatCurrency(
                                      widget.type == PaymentTypeEnum.reservation
                                          ? state.paymentsState.reservation!
                                              .payment!.total
                                          : state.paymentsState.scannedItem!
                                              .payment!.total),
                                  color: ColorsCustom.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            CustomText(
                              AppTranslations.of(context)!
                                  .text("payment_method"),
                              color: ColorsCustom.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: 15),
                            paymentMethodCard(
                              icon: Icons.wallet_outlined,
                              name: "Grid Cash",
                              suffix: CustomText(
                                Formatters.formatCurrency(
                                    state.userState.credit),
                                color: selectedPaymentMethod == "Grid Cash"
                                    ? ColorsCustom.white
                                    : ColorsCustom.black,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            paymentMethodCard(
                                icon: Icons.payments_outlined,
                                name: AppTranslations.of(context)!
                                    .text("other_payment"),
                                suffix: Icon(
                                  Icons.chevron_right_rounded,
                                  size: 20,
                                  color: selectedPaymentMethod ==
                                          AppTranslations.of(context)!
                                              .text("other_payment")
                                      ? ColorsCustom.white
                                      : ColorsCustom.disabled,
                                ))
                          ]),
                    )),
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
                    child: CustomButton(
                      onPressed: onPay,
                      text: AppTranslations.of(context)!.text("pay"),
                      textColor: ColorsCustom.white,
                      bgColor: ColorsCustom.pomegrande,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      borderRadius: BorderRadius.circular(8),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      margin: EdgeInsets.zero,
                    ),
                  ),
                )
              ]);
            }));
  }

  Widget rowTextInfo({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          label,
          color: ColorsCustom.disabled,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        CustomText(
          value,
          color: ColorsCustom.disabled,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  Widget paymentMethodCard(
      {required Widget suffix, required IconData icon, required String name}) {
    final bool isSelected = selectedPaymentMethod == name;
    return GestureDetector(
      onTap: () => selectPaymentMethod(name),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: const Offset(4, 0),
                  blurRadius: 12,
                  spreadRadius: 0,
                  color: Colors.black.withOpacity(0.1))
            ],
            color: isSelected ? ColorsCustom.green : ColorsCustom.white,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: isSelected ? ColorsCustom.white : ColorsCustom.green,
                    size: 24,
                  ),
                  const SizedBox(width: 15),
                  CustomText(
                    name,
                    color: isSelected ? ColorsCustom.white : ColorsCustom.black,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            suffix
          ],
        ),
      ),
    );
  }
}
