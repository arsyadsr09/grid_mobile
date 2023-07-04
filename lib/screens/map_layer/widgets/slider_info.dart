import 'package:flutter/material.dart';
import 'package:grid_mobile/helpers/helpers.dart';
import 'package:grid_mobile/widgets/custom_text.dart';

import '../../../localization/app_translations.dart';

class SliderInfo extends StatelessWidget {
  const SliderInfo({super.key, required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      alignment: Alignment.center,
      color: ColorsCustom.black.withOpacity(0.2),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        constraints: const BoxConstraints(minWidth: 150),
        decoration: BoxDecoration(
            color: ColorsCustom.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              AppTranslations.of(context)!.text("minimum_of"),
              color: ColorsCustom.disabled,
              fontSize: 9,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 5),
            CustomText(
              value.toStringAsFixed(0),
              color: ColorsCustom.black,
              fontSize: 36,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 5),
            CustomText(
              AppTranslations.of(context)!.text("charging_points"),
              color: ColorsCustom.black,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
            CustomText(
              AppTranslations.of(context)!.text("available_per_site"),
              color: ColorsCustom.disabled,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
