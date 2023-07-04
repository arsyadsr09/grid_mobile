import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart' show LatLng;
import 'package:grid_mobile/screens/home/widgets/status_card/widgets/direction_map.dart';
import 'package:grid_mobile/utils/formatter.dart';

import '../../../../../helpers/helpers.dart';
import '../../../../../localization/app_translations.dart';
import '../../../../../widgets/widgets.dart';

class ReservedCard extends StatelessWidget {
  const ReservedCard(
      {super.key,
      required this.isShow,
      required this.isStop,
      required this.minHeightShow,
      required this.minHeightHide,
      required this.statusText,
      required this.location,
      required this.slot,
      required this.statusBgColor,
      required this.statusIconColor,
      required this.expiredIn,
      required this.toggleIsShow,
      required this.toggleIsStop,
      required this.onClaimSlot,
      required this.onOpenDirection,
      required this.latLng});

  final bool isShow, isStop;
  final LatLng latLng;
  final double minHeightShow, minHeightHide;
  final String statusText, location, slot;
  final Color statusBgColor, statusIconColor;
  final DateTime expiredIn;
  final void Function() toggleIsShow,
      toggleIsStop,
      onClaimSlot,
      onOpenDirection;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: isShow ? null : toggleIsShow,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.maxFinite,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: ColorsCustom.black, borderRadius: BorderRadius.circular(16)),
        child: Stack(children: [
          AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              constraints: BoxConstraints(
                minHeight: isShow ? minHeightShow : minHeightHide,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(16)),
              width: screenSize.width,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      constraints: const BoxConstraints(minWidth: 200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
                      decoration: BoxDecoration(
                        color: statusBgColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CustomText(
                        statusText,
                        color: ColorsCustom.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 9,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    expiredInInfoAnimation(context),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.add_location_alt_outlined,
                          size: 24,
                          color: statusIconColor,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              AppTranslations.of(context)!.text("location"),
                              color: ColorsCustom.disabled,
                              fontWeight: FontWeight.w500,
                              fontSize: 9,
                            ),
                            CustomText(
                              location,
                              color: ColorsCustom.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                              height: 1.1,
                            ),
                            const SizedBox(height: 10),
                            CustomText(
                              AppTranslations.of(context)!.text("slot"),
                              color: ColorsCustom.disabled,
                              fontWeight: FontWeight.w500,
                              fontSize: 9,
                            ),
                            CustomText(
                              slot,
                              color: ColorsCustom.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                              height: 1.1,
                            ),
                          ],
                        )),
                        buttonOpenDirection(context, screenSize),
                      ],
                    ),
                    directionMap(),
                    Container(
                      height: 34,
                      margin: const EdgeInsets.only(top: 16),
                      child: CustomButton(
                        onPressed: onClaimSlot,
                        text: AppTranslations.of(context)!.text("claim_slot"),
                        textColor: ColorsCustom.white,
                        bgColor: ColorsCustom.green,
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                        borderRadius: BorderRadius.circular(8),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        margin: EdgeInsets.zero,
                      ),
                    ),
                    const SizedBox(height: 40),
                  ])),
          Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: toggleIsShow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      isShow
                          ? AppTranslations.of(context)!.text("hide")
                          : AppTranslations.of(context)!.text("show"),
                      color: ColorsCustom.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 9,
                    ),
                    Icon(
                      isShow
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      size: 18,
                      color: statusIconColor,
                    ),
                  ],
                ),
              ))
        ]),
      ),
    );
  }

  Widget directionMap() {
    return DirectionMap(
      isShow: isShow,
      latLng: latLng,
      onOpenDirection: onOpenDirection,
    );
  }

  Widget expiredInInfoAnimation(BuildContext context) {
    return AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: !isShow ? 1 : 0,
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: !isShow ? 55 : 0,
            padding: const EdgeInsets.only(top: 16),
            child: expiredInContent(context)));
  }

  Widget expiredInContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timer_outlined,
            size: 38,
            color: ColorsCustom.white,
          ),
          const SizedBox(width: 3),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                AppTranslations.of(context)!.text("expired_in"),
                color: ColorsCustom.disabled,
                fontWeight: FontWeight.w500,
                fontSize: 9,
                height: 1.1,
              ),
              CustomText(
                Formatters.getTime(expiredIn),
                color: ColorsCustom.white,
                fontWeight: FontWeight.w700,
                fontSize: 24,
                height: 1.1,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buttonOpenDirection(BuildContext context, Size screenSize) {
    return Stack(
      children: [
        AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isShow ? 1 : 0,
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: expiredInContent(context))),
        Positioned(
          right: 0,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: !isShow ? 1 : 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: !isShow ? 27 : 0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    backgroundColor: ColorsCustom.blue),
                onPressed: onOpenDirection,
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(
                    Icons.directions,
                    size: 14,
                    color: ColorsCustom.white,
                  ),
                  const SizedBox(width: 6),
                  CustomText(
                    AppTranslations.of(context)!.text("open_direction"),
                    color: ColorsCustom.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 9,
                  ),
                ]),
              ),
            ),
          ),
        )
      ],
    );
  }
}
