import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grid_mobile/helpers/helpers.dart';
import '../../localization/app_translations.dart';
import '../../widgets/widgets.dart';
import './location_permission_view_model.dart';

class LocationPermissionView extends LocationPermissionViewModel {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // Replace this with your build function
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                width: screenSize.width / 1.8,
                child: Image.asset("assets/images/location_permission.png"),
              ),
               CustomText(
                AppTranslations.of(context)!.text("location_permission"),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 20),
              Expanded(
                  child: Scrollbar(
                      child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          children: policyText
                              .map((e) => textPolicy(e['value'], e['title']))
                              .toList()))),
              Padding(
                padding: EdgeInsets.only(
                    top: 20, bottom: Platform.isAndroid ? 10 : 0),
                child: CustomButton(
                    bgColor: ColorsCustom.primary,
                    text: AppTranslations.of(context)!.text("i_agree"),
                    textColor: ColorsCustom.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    onPressed: onApproveClicked),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textPolicy(String value, [bool isTitle = false]) {
    return isTitle
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CustomText(
              value,
              fontSize: isTitle ? 16 : 14,
              fontWeight: isTitle ? FontWeight.w500 : FontWeight.w400,
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 2.5, right: 8),
                  child: CustomText(
                    "●",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Expanded(
                  child: CustomText(
                    value,
                    fontSize: isTitle ? 17 : 14,
                    fontWeight: isTitle ? FontWeight.w500 : FontWeight.w400,
                  ),
                )
              ],
            ),
          );
  }
}
