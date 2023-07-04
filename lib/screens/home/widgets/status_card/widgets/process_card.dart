import 'package:flutter/material.dart';

import '../../../../../helpers/helpers.dart';
import '../../../../../localization/app_translations.dart';
import '../../../../../widgets/widgets.dart';
import 'energy_chart.dart';

class ProcessCard extends StatelessWidget {
  const ProcessCard(
      {super.key,
      required this.isShow,
      required this.minHeightShow,
      required this.minHeightHide,
      required this.progress,
      required this.totalPower,
      required this.currentPower,
      required this.statusBgColor,
      required this.statusIconColor,
      required this.statusText,
      required this.statusDetailText,
      required this.statusDetailIcon,
      required this.toggleIsShow,
      required this.toggleIsStop,
      required this.isStop});

  final bool isShow, isStop;
  final double minHeightShow, minHeightHide, progress, totalPower, currentPower;
  final Color statusBgColor, statusIconColor;
  final String statusText, statusDetailText;
  final IconData statusDetailIcon;
  final void Function() toggleIsShow, toggleIsStop;

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
        child: Stack(
          children: [
            progressAnimation(screenSize),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              constraints: BoxConstraints(
                  minHeight: isShow ? minHeightShow : minHeightHide),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              width: screenSize.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    constraints: const BoxConstraints(minWidth: 200),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    decoration: BoxDecoration(
                      color: statusBgColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          "$statusText - ",
                          color: ColorsCustom.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 9,
                        ),
                        CustomText(
                          "${progress.round()}%",
                          color: ColorsCustom.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 9,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              statusDetailIcon,
                              size: 30,
                              color: statusIconColor,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  AppTranslations.of(context)!.text("power"),
                                  color: ColorsCustom.disabled,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 7,
                                ),
                                CustomText(
                                  statusDetailText,
                                  color: ColorsCustom.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.bolt_outlined,
                              size: 30,
                              color: statusIconColor,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  AppTranslations.of(context)!
                                      .text("power_transfer"),
                                  color: ColorsCustom.disabled,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 7,
                                ),
                                CustomText(
                                  "${currentPower.toStringAsFixed(1)} ${AppTranslations.of(context)!.text("kwh")}, / ${totalPower.toStringAsFixed(1)} ${AppTranslations.of(context)!.text("kwh")}",
                                  color: ColorsCustom.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  EnergyChart(isShow: isShow, statusBgColor: statusBgColor),
                  sliderStopButton(context, screenSize),
                  isShow ? const SizedBox(height: 40) : const SizedBox(),
                ],
              ),
            ),
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
          ],
        ),
      ),
    );
  }

  Widget progressAnimation(Size screenSize) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: ((screenSize.width - 30) / 100) * progress,
      constraints:
          BoxConstraints(minHeight: isShow ? minHeightShow : minHeightHide),
      decoration: BoxDecoration(
          color: statusBgColor.withOpacity(0.3),
          borderRadius: progress < 97
              ? const BorderRadius.only(
                  topLeft: Radius.circular(16), bottomLeft: Radius.circular(16))
              : BorderRadius.circular(16)),
    );
  }

  Widget sliderStopButton(BuildContext context, Size screenSize) {
    return AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isShow ? 1 : 0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(top: 10),
          height: isShow && !isStop ? 45 : 0,
          child: CustomSliderButton(
            action: () {
              toggleIsStop();
            },

            ///Put label over here
            alignLabel: Alignment.center,
            label: CustomText(
                AppTranslations.of(context)!.text("slide_to_stop_charging"),
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
            buttonColor: ColorsCustom.primary,
            backgroundColor: ColorsCustom.disabled.withOpacity(0.6),
            highlightedColor: Colors.white,
            baseColor: ColorsCustom.primary,
          ),
        ));
  }
}
