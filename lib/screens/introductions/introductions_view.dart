import 'package:flutter/material.dart';
import '../../helpers/helpers.dart';
import '../../widgets/widgets.dart';
import './introductions_view_model.dart';
import 'widgets/custom_introduction.dart';

class IntroductionsView extends IntroductionsViewModel {
  @override
  Widget build(BuildContext context) {
    // Replace this with your build function
    return CustomIntroductionScreen(
      pages: pages,
      onDone: () => onDone(),
      onSkip: () => onDone(),
      showSkipButton: true,
      showNextButton: true,
      skip: CustomText(
        "Skip",
        color: ColorsCustom.primary,
      ),
      next: const Icon(Icons.arrow_forward),
      done: const SizedBox(),

      isProgressTap: false,
      isProgress: false,

      // dotsDecorator: DotsDecorator(
      //     size: const Size.square(10.0),
      //     activeSize: const Size(20.0, 10.0),
      //     activeColor: ColorsCustom.primary,
      //     color: Colors.black26,
      //     spacing: const EdgeInsets.symmetric(horizontal: 3.0),
      //     activeShape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(25.0))),
    );
  }
}
