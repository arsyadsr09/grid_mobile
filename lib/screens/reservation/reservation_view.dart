import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:grid_mobile/helpers/helpers.dart';
import 'package:grid_mobile/screens/reservation/widgets/reservation_map.dart';
import '../../constants/dummy_data.dart';
import '../../localization/app_translations.dart';
import '../../redux/app_state.dart';
import '../../redux/modules/payments_state.dart';
import '../../widgets/widgets.dart';
import './reservation_view_model.dart';

class ReservationView extends ReservationViewModel {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: StoreConnector<AppState, PaymentsState>(
            converter: (store) => store.state.paymentsState,
            builder: (context, state) {
              return Stack(children: [
                const HeaderPage(title: "Reservation"),
                Positioned(
                    left: 20,
                    right: 20,
                    top: 90,
                    bottom: 0,
                    child: ListView(
                        padding: const EdgeInsets.only(bottom: 80),
                        shrinkWrap: true,
                        children: [
                          CustomText(
                            AppTranslations.of(context)!.text("location"),
                            color: ColorsCustom.disabled,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                          const SizedBox(height: 10),
                          CustomText(
                            DummyData.selectedMarker.name,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          const SizedBox(height: 5),
                          CustomText(
                            DummyData.selectedMarker.address,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: ColorsCustom.disabled,
                          ),
                          ReservationMap(
                            latLng: initLatLng,
                            onOpenDirection: () {},
                          ),
                          const SizedBox(height: 15),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 40,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Switch(
                                      inactiveThumbColor: ColorsCustom.disabled,
                                      inactiveTrackColor:
                                          ColorsCustom.green.withOpacity(0.2),
                                      activeColor: ColorsCustom.green,
                                      value: pickMySpace,
                                      onChanged: togglePickMySpace),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomText(
                                    AppTranslations.of(context)!
                                        .text("i_want_to_pick_my_space"),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                  ),
                                  CustomText(
                                    AppTranslations.of(context)!
                                        .text("you_will_be_charged"),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 9,
                                    color: ColorsCustom.disabled,
                                  ),
                                ],
                              ))
                            ],
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: pickMySpace ? 1 : 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 15),
                                CustomText(
                                  AppTranslations.of(context)!
                                      .text("blueprint"),
                                  color: ColorsCustom.disabled,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(height: 10),
                                Container(
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                            width: 1,
                                            color: ColorsCustom.border)),
                                    child: Image.asset(
                                      "assets/images/blueprint.jpg",
                                      fit: BoxFit.fill,
                                    )),
                                const SizedBox(height: 10),
                                CustomText(
                                  AppTranslations.of(context)!
                                      .text("pick_a_space"),
                                  color: ColorsCustom.disabled,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(height: 10),
                                ...initSpace
                                    .map((e) => listSpace(
                                        isAvail: e['is_avail'],
                                        isSelected: selectedSpace == e['id'],
                                        name: e['name'],
                                        id: e['id'],
                                        chargingPorts: e['charging_ports'],
                                        screenSize: screenSize))
                                    .toList()
                              ],
                            ),
                          )
                        ])),
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
              ]);
            }));
  }

  Widget listSpace(
      {required bool isAvail,
      required bool isSelected,
      required String name,
      required String id,
      required List<int> chargingPorts,
      required Size screenSize}) {
    return Stack(
      children: [
        AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isSelected ? 1 : 0,
            child: AnimatedContainer(
              margin:
                  const EdgeInsets.only(top: 30, bottom: 8, left: 8, right: 8),
              padding: const EdgeInsets.only(
                  top: 20, left: 10, right: 10, bottom: 10),
              duration: const Duration(milliseconds: 300),
              height: isSelected ? 170 : 0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: ColorsCustom.border)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 15),
                    child: CustomText(
                      AppTranslations.of(context)!.text("select_one_connector"),
                      color: ColorsCustom.disabled,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: chargingPorts
                        .map((i) => GestureDetector(
                              onTap: () => setSelectedPort(i),
                              child: Container(
                                width: (screenSize.width - 60) / 4,
                                height: (screenSize.width - 60) / 4,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: ColorsCustom.whiteSecondary,
                                    border: Border.all(
                                        width: 2,
                                        color: selectedPort == i
                                            ? ColorsCustom.primary
                                            : Colors.transparent)),
                                child: Image.asset(
                                  "assets/images/type_charging/raw/$i.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ))
                        .toList(),
                  )
                ],
              ),
            )),
        GestureDetector(
          onTap: () => isAvail ? setSelectedSpace(id) : {},
          child: Opacity(
            opacity: isAvail ? 1 : 0.7,
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: isAvail ? ColorsCustom.white : ColorsCustom.cloud,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    width: 2,
                    color:
                        isSelected ? ColorsCustom.primary : Colors.transparent),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(4, 0),
                      blurRadius: 12,
                      spreadRadius: 0,
                      color: Colors.black.withOpacity(0.1))
                ],
              ),
              child: ListTile(
                visualDensity: const VisualDensity(vertical: -2),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                leading: CustomText(
                  name,
                  color: ColorsCustom.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                title: CustomText(
                  "${isAvail ? "" : "${AppTranslations.of(context)!.text("not")} "}${AppTranslations.of(context)!.text("available")}",
                  color: isAvail ? ColorsCustom.green : ColorsCustom.pomegrande,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
                trailing: isSelected
                    ? Icon(
                        Icons.check_circle_outline_rounded,
                        size: 20,
                        color: ColorsCustom.green,
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: chargingPorts
                            .map((i) => Container(
                                  width: 33,
                                  height: 33,
                                  margin: const EdgeInsets.only(left: 8),
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(33),
                                    color: ColorsCustom.whiteSecondary,
                                  ),
                                  child: Image.asset(
                                    "assets/images/type_charging/raw/$i.png",
                                    fit: BoxFit.contain,
                                  ),
                                ))
                            .toList()),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
