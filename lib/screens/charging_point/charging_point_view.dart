import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:grid_mobile/helpers/colors_custom.dart';
import 'package:grid_mobile/redux/modules/payments_state.dart';
import 'package:grid_mobile/widgets/widgets.dart';
import '../../localization/app_translations.dart';
import '../../redux/app_state.dart';
import './charging_point_view_model.dart';

class ChargingPointView extends ChargingPointViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, PaymentsState>(
          converter: (store) => store.state.paymentsState,
          builder: (context, state) {
            return Stack(
              children: [
                const HeaderPage(
                  title: "Charging Points",
                ),
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 0,
                  top: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        AppTranslations.of(context)!.text("location"),
                        color: ColorsCustom.disabled,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        state.scannedItem?.data?.name,
                        color: ColorsCustom.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 15),
                      CustomText(
                        "CHARGING POINT ID",
                        color: ColorsCustom.disabled,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        state.scannedItem?.data?.id,
                        color: ColorsCustom.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                AppTranslations.of(context)!
                                    .text("charging_type"),
                                color: ColorsCustom.disabled,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                              const SizedBox(height: 5),
                              CustomDropdown(
                                dataList: chargingTypeData,
                                name: AppTranslations.of(context)!
                                    .text("charging_type"),
                                value: chargingTypeValue,
                                onChange: setChargingTypeValue,
                              )
                            ],
                          )),
                          const SizedBox(width: 8),
                          Expanded(
                              child: chargingTypeValue == 'Full Charging'
                                  ? const SizedBox()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomText(
                                          AppTranslations.of(context)!
                                              .text("amount"),
                                          color: ColorsCustom.disabled,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        const SizedBox(height: 5),
                                        FormAmount(
                                          hint: AppTranslations.of(context)!
                                              .text("first_name"),
                                          controller: amountController,
                                          preffix: handlePrefixAmount() == 'IDR'
                                              ? handlePrefixAmount()
                                              : "",
                                          suffix: handlePrefixAmount() == 'KWH'
                                              ? handlePrefixAmount()
                                              : "",
                                          onTap: onAmountTap,
                                        ),
                                      ],
                                    )),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                AppTranslations.of(context)!
                                    .text("parking_ticket"),
                                color: ColorsCustom.disabled,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                              CustomText(
                                parkingTicketID,
                                color: ColorsCustom.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          )),
                          SizedBox(
                            height: 30,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 10),
                                  backgroundColor: ColorsCustom.sunflower,
                                  foregroundColor: ColorsCustom.sunflower,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4))),
                              onPressed: onGetImageFromCamera,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.qr_code_scanner_rounded,
                                    size: 15,
                                    color: ColorsCustom.black,
                                  ),
                                  const SizedBox(width: 8),
                                  CustomText(
                                    AppTranslations.of(context)!
                                        .text("scan_parking_ticket"),
                                    color: ColorsCustom.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      imageSelector != null
                          ? CustomText(
                              AppTranslations.of(context)!
                                  .text("parking_ticket_photo"),
                              color: ColorsCustom.disabled,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            )
                          : const SizedBox(),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: double.maxFinite,
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: imageSelector != null
                              ? Image.file(imageSelector!, fit: BoxFit.cover)
                              : const SizedBox(),
                        ),
                      )
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
                    child: CustomButton(
                      onPressed: onContinue,
                      text: AppTranslations.of(context)!.text("continue"),
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
              ],
            );
          }),
    );
  }
}
