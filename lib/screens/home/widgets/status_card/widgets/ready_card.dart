import 'package:flutter/material.dart';

import '../../../../../helpers/helpers.dart';
import '../../../../../localization/app_translations.dart';
import '../../../../../utils/formatter.dart';
import '../../../../../widgets/widgets.dart';

class ReadyCard extends StatelessWidget {
  const ReadyCard(
      {super.key,
      required this.onStartCharging,
      required this.statusBgColor,
      required this.statusIconColor,
      required this.statusText,
      required this.location,
      required this.slot,
      required this.expiredIn});

  final Color statusBgColor, statusIconColor;
  final String statusText, location, slot;
  final DateTime expiredIn;
  final void Function() onStartCharging;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: ColorsCustom.black,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                offset: const Offset(4, 0),
                blurRadius: 12,
                spreadRadius: 0,
                color: Colors.black.withOpacity(0.1))
          ]),
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: const BoxConstraints(minWidth: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
              const SizedBox(height: 16),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                expiredInContent(context)
              ]),
              sliderStartButton(screenSize, context),
            ],
          ),
        ),
      ]),
    );
  }

  Widget expiredInContent(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }

  Widget sliderStartButton(Size screenSize, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 8),
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
        width: screenSize.width - 60,
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
