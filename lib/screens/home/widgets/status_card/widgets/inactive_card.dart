import 'package:flutter/material.dart';
import 'package:grid_mobile/widgets/widgets.dart';

import '../../../../../helpers/helpers.dart';

class InactiveCard extends StatelessWidget {
  const InactiveCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
          color: ColorsCustom.black,
          borderRadius: BorderRadius.circular(16),
          image: const DecorationImage(
              image: AssetImage("assets/images/background_inactive_status.png"),
              fit: BoxFit.fitWidth),
          boxShadow: [
            BoxShadow(
                offset: const Offset(4, 0),
                blurRadius: 12,
                spreadRadius: 0,
                color: Colors.black.withOpacity(0.15))
          ]),
      child: Stack(children: [
        SizedBox(
          height: 70,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                "Welcome to ",
                color: ColorsCustom.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              CustomText(
                "Grid",
                color: ColorsCustom.primary,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ],
          ),
        )
      ]),
    );
  }
}