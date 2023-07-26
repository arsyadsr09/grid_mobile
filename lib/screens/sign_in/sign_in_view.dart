import 'package:flutter/material.dart';
import '../../helpers/helpers.dart';
import '../../localization/app_translations.dart';
import '../../widgets/widgets.dart';
import './sign_in_view_model.dart';

class SignInView extends SignInViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          height: double.maxFinite,
          width: double.infinity,
          child: ListView(
            padding: const EdgeInsets.only(bottom: 100),
            children: [
              const SizedBox(height: 20),
              Center(
                child: Image.asset(
                  "assets/images/grid_logo.png",
                  width: 75,
                ),
              ),
              const SizedBox(height: 100),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, bottom: 30),
                      child: CustomText(
                        AppTranslations.of(context)!.text("sign_in"),
                        color: ColorsCustom.black,
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    errorEmail != "" && emailController.text.isEmpty
                        ? ErrorForm(error: errorEmail)
                        : const SizedBox(),
                    FormText(
                        hint: AppTranslations.of(context)!.text("email"),
                        controller: emailController,
                        onChange: clearError,
                        onClear: onClearTextField,
                        errorMessage: errorEmail,
                        withClear: true,
                        preffix: Icon(
                          Icons.person_outline_rounded,
                          size: 24,
                          color: ColorsCustom.primary,
                        ),
                        idError: "email"),
                    FormText(
                        hint: AppTranslations.of(context)!.text("password"),
                        controller: passwordController,
                        onChange: clearError,
                        onClear: onClearTextField,
                        obscureText: true,
                        preffix: Icon(
                          Icons.key_outlined,
                          size: 24,
                          color: ColorsCustom.primary,
                        ),
                        errorMessage: errorPassword,
                        idError: "password"),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15, top: 10),
                        child: CustomText(
                          "${AppTranslations.of(context)!.text("forgot_password")}?",
                          color: ColorsCustom.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ]),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: ColorsCustom.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                  ),
                  boxShadow: MediaQuery.of(context).viewInsets.bottom == 0
                      ? []
                      : [
                          BoxShadow(
                              offset: const Offset(4, 0),
                              blurRadius: 12,
                              spreadRadius: 0,
                              color: Colors.black.withOpacity(0.1))
                        ]),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                CustomButton(
                  bgColor: ColorsCustom.primary,
                  text: "Continue",
                  textColor: ColorsCustom.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  onPressed: onSignIn,
                ),
                MediaQuery.of(context).viewInsets.bottom == 0
                    ? CustomButton(
                        onPressed: () => Navigator.pop(context),
                        flat: true,
                        text: "Back",
                        textColor: ColorsCustom.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      )
                    : const SizedBox(),
              ]),
            )),
        const CustomLoadingPage()
      ],
    ));
  }
}
