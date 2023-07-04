import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../helpers/helpers.dart';
import '../../localization/app_translations.dart';
import '../../widgets/widgets.dart';
import './verify_otp_view_model.dart';

class VerifyOtpView extends VerifyOtpViewModel {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: CustomText(
                          AppTranslations.of(context)!.text("verify_otp"),
                          color: ColorsCustom.black,
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text:
                                "${AppTranslations.of(context)!.text("verify_text_1")} ",
                            style: const TextStyle(
                                color: Color(0xFF282828),
                                fontSize: 13,
                                height: 2,
                                fontFamily: 'Poppins'),
                            children: [
                              TextSpan(
                                  text: widget.email,
                                  style: TextStyle(
                                      color: ColorsCustom.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                              TextSpan(
                                  text:
                                      ". ${AppTranslations.of(context)!.text("verify_text_2")}.")
                            ]),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: Container(
                          width: screenSize.width - 100,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 30),
                          child: PinCodeTextField(
                              appContext: context,
                              backgroundColor: Colors.transparent,
                              pinTheme: PinTheme(
                                activeColor: ColorsCustom.primary,
                                activeFillColor: ColorsCustom.primary,
                                selectedColor:
                                    ColorsCustom.primary.withOpacity(0.7),
                                inactiveColor:
                                    ColorsCustom.primary.withOpacity(0.4),
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(8),
                                fieldHeight: 50,
                                fieldWidth: 50,
                              ),
                              textStyle: const TextStyle(
                                  color: Color(0xFF282828),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                              length: 4,
                              cursorColor:
                                  ColorsCustom.primary.withOpacity(0.7),
                              controller: otpController,
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              animationType: AnimationType.fade,
                              animationDuration:
                                  const Duration(milliseconds: 200),
                              onChanged: (_) => clearError())),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: errorOtp != ""
                          ? Container(
                              margin:
                                  const EdgeInsets.only(top: 20, bottom: 30),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              // decoration: BoxDecoration(
                              //     color: Color(0xFF1e90ff).withOpacity(0.3),
                              //     borderRadius: BorderRadius.circular(30)),
                              child: CustomText(
                                errorOtp,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w400,
                                color: ColorsCustom.primary,
                                fontSize: 13,
                              ))
                          : startTimer > 0
                              ? CustomText(
                                  "${leadingZero(startTimer ~/ 60)}:${leadingZero(startTimer % 60)}",
                                  textAlign: TextAlign.center,
                                  color: ColorsCustom.black,
                                  fontSize: 12,
                                )
                              : const SizedBox(),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            "${AppTranslations.of(context)!.text("resend_text")}? ",
                            style: const TextStyle(
                                color: Color(0xFF282828),
                                fontSize: 12,
                                fontFamily: 'Poppins')),
                        GestureDetector(
                            child: Text(
                                AppTranslations.of(context)!
                                    .text("resend_code"),
                                style: TextStyle(
                                    color: !resendActive
                                        ? Colors.grey
                                        : ColorsCustom.primary,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    fontSize: 13)))
                      ],
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
                              color: Colors.black.withOpacity(0.15))
                        ]),
              child: CustomButton(
                bgColor: ColorsCustom.primary,
                text: AppTranslations.of(context)!.text("verify"),
                textColor: ColorsCustom.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ))
      ],
    ));
  }
}
