import 'package:flutter/material.dart';
import '../../helpers/helpers.dart';
import '../../localization/app_translations.dart';
import '../../widgets/widgets.dart';
import './landing_view_model.dart';

class LandingView extends LandingViewModel {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          padding: const EdgeInsets.only(bottom: 20),
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              "assets/images/background_landing.jpg",
            ),
            fit: BoxFit.cover,
          )),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 80),
                    Image.asset(
                      "assets/images/grid_logo.png",
                      width: screenSize.width / 3,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      CustomButton(
                        bgColor: ColorsCustom.black,
                        text:
                            "${AppTranslations.of(context)!.text("continue_with")} Apple",
                        textColor: ColorsCustom.white,
                        fontWeight: FontWeight.w600,
                        icon: Icons.apple_outlined,
                        colorIcon: ColorsCustom.white,
                        fontSize: 16,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        margin: const EdgeInsets.symmetric(vertical: 6),
                      ),
                      CustomButton(
                        bgColor: Colors.white,
                        text:
                            "${AppTranslations.of(context)!.text("continue_with")} Google",
                        textColor: ColorsCustom.black,
                        fontWeight: FontWeight.w600,
                        image: Image.asset(
                          "assets/images/google_logo.png",
                          width: 28,
                        ),
                        fontSize: 16,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        margin: const EdgeInsets.symmetric(vertical: 6),
                      ),
                      Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: ColorsCustom.white.withOpacity(0.5),
                                thickness: 1,
                                height: 40,
                              ),
                            ),
                            const SizedBox(width: 15),
                            CustomText(
                              AppTranslations.of(context)!.text("or"),
                              color: ColorsCustom.white.withOpacity(0.75),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Divider(
                                color: ColorsCustom.white.withOpacity(0.5),
                                thickness: 1,
                                height: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomButton(
                        onPressed: onSignIn,
                        bgColor: ColorsCustom.primary,
                        text: AppTranslations.of(context)!.text("sign_in"),
                        textColor: ColorsCustom.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            "${AppTranslations.of(context)!.text("new_user")}?",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: ColorsCustom.white,
                          ),
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, "/SignUp"),
                            child: CustomText(
                              " ${AppTranslations.of(context)!.text("sign_up")}",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: ColorsCustom.primary,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
