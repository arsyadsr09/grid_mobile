import 'package:flutter/material.dart';
import 'package:grid_mobile/helpers/helpers.dart';
import 'package:grid_mobile/widgets/custom_text.dart';

import '../../../localization/app_translations.dart';

class WrongBarcode extends StatelessWidget {
  const WrongBarcode({super.key, required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      alignment: Alignment.center,
      color: ColorsCustom.black.withOpacity(0.4),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        constraints: BoxConstraints(minWidth: screenSize.width / 1.5),
        decoration: BoxDecoration(
            color: ColorsCustom.pomegrande,
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: 36,
              color: ColorsCustom.white,
            ),
            const SizedBox(height: 5),
            CustomText(
              AppTranslations.of(context)!.text("barcode_error"),
              color: ColorsCustom.white,
              fontSize: 9,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
