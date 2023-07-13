import 'package:flutter/material.dart';
import '../../helpers/helpers.dart';
import '../../localization/app_translations.dart';
import '../../widgets/widgets.dart';
import './sign_up_view_model.dart';

class SignUpView extends SignUpViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          height: double.maxFinite,
          width: double.infinity,
          child: ListView(
            padding: const EdgeInsets.only(bottom: 200),
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
                        AppTranslations.of(context)!.text("sign_up"),
                        color: ColorsCustom.black,
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    FormText(
                        hint: AppTranslations.of(context)!.text("first_name"),
                        controller: firstnameController,
                        onChange: clearError,
                        onClear: onClearTextField,
                        errorMessage: firstnameController.text.isNotEmpty
                            ? errorFirstname
                            : "",
                        withClear: true,
                        preffix: Icon(
                          Icons.person_outlined,
                          size: 24,
                          color: ColorsCustom.primary,
                        ),
                        idError: "firstname"),
                    FormText(
                        hint: AppTranslations.of(context)!.text("last_name"),
                        controller: lastnameController,
                        onChange: clearError,
                        onClear: onClearTextField,
                        errorMessage: lastnameController.text.isNotEmpty
                            ? errorLastname
                            : "",
                        withClear: true,
                        preffix: Icon(
                          Icons.person_outlined,
                          size: 24,
                          color: ColorsCustom.primary,
                        ),
                        idError: "lastname"),
                    FormText(
                        hint: AppTranslations.of(context)!.text("email"),
                        controller: emailController,
                        onChange: clearError,
                        onClear: onClearTextField,
                        errorMessage:
                            emailController.text.isNotEmpty ? errorEmail : "",
                        withClear: true,
                        preffix: Icon(
                          Icons.email_outlined,
                          size: 24,
                          color: ColorsCustom.primary,
                        ),
                        idError: "email"),
                    FormText(
                        hint: AppTranslations.of(context)!.text("phone_number"),
                        controller: phoneNumberController,
                        onChange: clearError,
                        onClear: onClearTextField,
                        errorMessage: phoneNumberController.text.isNotEmpty
                            ? errorPhoneNumber
                            : "",
                        withClear: true,
                        phone: true,
                        keyboard: TextInputType.phone,
                        preffix: Icon(
                          Icons.phone_rounded,
                          size: 24,
                          color: ColorsCustom.primary,
                        ),
                        idError: "phoneNumber"),
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
                        errorMessage: passwordController.text.isNotEmpty
                            ? errorPassword
                            : "",
                        idError: "password"),
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
                  onPressed: onSignUp,
                  bgColor: ColorsCustom.primary,
                  text: AppTranslations.of(context)!.text("continue"),
                  textColor: ColorsCustom.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                MediaQuery.of(context).viewInsets.bottom == 0
                    ? CustomButton(
                        onPressed: () => Navigator.pop(context),
                        flat: true,
                        text: AppTranslations.of(context)!.text("back"),
                        textColor: ColorsCustom.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      )
                    : const SizedBox(),
              ]),
            ))
      ],
    ));
  }
}
