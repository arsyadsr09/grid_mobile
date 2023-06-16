import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/helpers.dart';
import '../../widgets/widgets.dart';
import './introductions.dart';

abstract class IntroductionsViewModel extends State<Introductions> {
  List<PageViewModel> pages = [
    buildPageViewModel(
        title: "Start Your Journey",
        desc:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        index: 1),
    buildPageViewModel(
        title: "Everywhere, Anywhere",
        desc:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        index: 2),
    buildPageViewModel(
        title: "Ready 24 hours",
        desc:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        index: 3),
  ];

  static PageViewModel buildPageViewModel({
    required String title,
    required String desc,
    required int index,
  }) {
    return PageViewModel(
      titleWidget: CustomText(
        title,
        color: ColorsCustom.black,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      // title: "Enjoy Your Trip",
      bodyWidget: Column(
        children: [
          CustomText(
            desc,
            color: ColorsCustom.generalText,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 85),
          dotsCustom(index),
        ],
      ),
      decoration: const PageDecoration(
          imagePadding: EdgeInsets.zero, imageFlex: 1, bodyFlex: 1),
      image: SvgPicture.asset(
        "assets/images/introductions/introduction_$index.svg",
      ),
    );
  }

  static Widget dotsCustom(int number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          height: 10,
          width: 10,
          decoration: BoxDecoration(
              color: number == 1 ? ColorsCustom.primary : ColorsCustom.border,
              borderRadius: BorderRadius.circular(5)),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          height: 10,
          width: 10,
          decoration: BoxDecoration(
              color: number == 2 ? ColorsCustom.primary : ColorsCustom.border,
              borderRadius: BorderRadius.circular(5)),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          height: 10,
          width: 10,
          decoration: BoxDecoration(
              color: number == 3 ? ColorsCustom.primary : ColorsCustom.border,
              borderRadius: BorderRadius.circular(5)),
        )
      ],
    );
  }

  Future<void> onDone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('introduction', true);

    // ignore: use_build_context_synchronously
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/Layout', (Route<dynamic> route) => false);
  }
}
