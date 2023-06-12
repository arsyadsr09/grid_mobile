import 'package:flutter/material.dart';
import 'package:grid_mobile/widgets/custom_text.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:grid_mobile/utils/colors_custom.dart';
import './introduction_view_model.dart';

class IntroductionView extends IntroductionViewModel {
  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 17.0, fontFamily: "Poppins");

    const pageDecoration = PageDecoration(
        titleTextStyle: TextStyle(
            fontSize: 28.0, fontWeight: FontWeight.w700, fontFamily: "Poppins"),
        bodyTextStyle: bodyStyle,
        bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        pageColor: Colors.white,
        imagePadding: EdgeInsets.zero,
        imageFlex: 2);

    // Replace this with your build function
    return IntroductionScreen(
      key: introKey,
      isTopSafeArea: true,
      isBottomSafeArea: true,
      globalBackgroundColor: Colors.white,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 5, right: 16),
            child: buildImage('logo-petakita-m.png', 100),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Abadikan Momen Melalui Peta",
          body: "Satu peta untuk ragam aktifitas",
          image: buildImage('onboarding-1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Simpan Lokasi Melalui Tagging",
          body: "Tandai area yang ingin kamu simpan kapan saja",
          image: buildImage('onboarding-2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Track Perjalanan dengan Mudah",
          body: "Lihat titik lokasi perjalanan yang akan ditempuh",
          image: buildImage('onboarding-3.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Tetap Terhubung dikala Offline",
          body: "Sinkronisasi lokasi tagging dikala offline",
          image: buildImage('onboarding-4.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => onIntroEnd(context),
      onSkip: () => onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,

      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const CustomText('Lewati',
          fontWeight: FontWeight.w500, color: Colors.white),
      next: const Icon(Icons.arrow_forward, color: Colors.white),
      done: const CustomText('Selesai',
          fontWeight: FontWeight.w500, color: Colors.white),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        activeColor: Colors.white,
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: ShapeDecoration(
        color: ColorsCustom.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
      ),
    );
  }
}
