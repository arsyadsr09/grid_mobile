import 'package:flutter/material.dart';

import '../../../../../helpers/helpers.dart';
import '../../../../../localization/app_translations.dart';
import '../../../../../widgets/widgets.dart';

class DoneCard extends StatelessWidget {
  const DoneCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
          color: ColorsCustom.black,
          borderRadius: BorderRadius.circular(16),
          image: const DecorationImage(
              image: AssetImage("assets/images/background_inactive_status.png"),
              fit: BoxFit.cover),
          boxShadow: [
            BoxShadow(
                offset: const Offset(4, 0),
                blurRadius: 12,
                spreadRadius: 0,
                color: Colors.black.withOpacity(0.15))
          ]),
      child: Stack(children: [
        SizedBox(
          width: screenSize.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                AppTranslations.of(context)!.text("thank_you_for_using_grid"),
                color: ColorsCustom.primary,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
              const SizedBox(height: 5),
              CustomText(
                AppTranslations.of(context)!.text("be_careful_on_the_way"),
                color: ColorsCustom.white,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
                fontSize: 22,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
