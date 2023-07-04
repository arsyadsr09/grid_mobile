import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grid_mobile/helpers/helpers.dart';
import 'package:grid_mobile/widgets/custom_text.dart';

import '../../localization/app_translations.dart';
import './widgets/widgets.dart';
import './home_view_model.dart';

class HomeView extends HomeViewModel {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));

    final screenSize = MediaQuery.of(context).size;
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: [
        Stack(
          children: [
            Container(
              constraints: BoxConstraints(minHeight: screenSize.height),
              color: Colors.white,
            ),
            Container(
              height: 230,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background_home.png"),
                    alignment: Alignment.bottomCenter,
                    fit: BoxFit.fitWidth),
              ),
            ),
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: SafeArea(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/images/grid_logo.png",
                                  width: 60,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomText(
                                      "Denpasar",
                                      color: ColorsCustom.white,
                                      fontSize: 12,
                                    ),
                                    const SizedBox(width: 5),
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: ColorsCustom.white,
                                      size: 16,
                                    )
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 7),
                            CustomText(
                              "Grid Cash",
                              color: ColorsCustom.white,
                              fontSize: 12,
                            ),
                            const SizedBox(height: 7),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  "Rp",
                                  color: ColorsCustom.white,
                                  fontSize: 12,
                                ),
                                const SizedBox(width: 5),
                                CustomText(
                                  "350.000",
                                  color: ColorsCustom.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: Container(
                                width: double.maxFinite,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                    color: ColorsCustom.primary,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Row(children: [
                                  buttonTopBar(
                                      icon: Icons.qr_code_scanner_rounded,
                                      name: AppTranslations.of(context)!
                                          .text("qr_scan"),
                                      onTap: () => Navigator.pushNamed(
                                          context, "/Scanner")),
                                  buttonTopBar(
                                      icon: Icons.wallet_outlined,
                                      name: AppTranslations.of(context)!
                                          .text("top_up")),
                                  buttonTopBar(
                                      icon: Icons.call_made_rounded,
                                      name: AppTranslations.of(context)!
                                          .text("send")),
                                  buttonTopBar(
                                      icon: Icons.call_received_rounded,
                                      name: AppTranslations.of(context)!
                                          .text("request")),
                                ]),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Scrollbar(
                          child: ListView(
                              shrinkWrap: true,
                              controller: scrollController,
                              padding:
                                  const EdgeInsets.fromLTRB(15, 0, 15, 100),
                              children: const [
                                StatusCard(),
                                SizedBox(height: 16),
                                MiniMap(),
                                SizedBox(height: 16),
                                LatestTransactions(),
                              ]),
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ],
    );
  }

  Widget buttonTopBar(
      {required IconData icon, required String name, void Function()? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 24,
                color: ColorsCustom.white,
              ),
              CustomText(
                name,
                color: ColorsCustom.white,
                fontSize: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
