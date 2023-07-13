import 'package:flutter/material.dart';

import '../helpers/helpers.dart';
import 'custom_text.dart';

class HeaderPage extends StatelessWidget {
  final Color? bgColor, itemColor, titleColor;
  final String? title;
  final List<Widget>? actions;
  final bool noCallPop, noBack, isBackToHome;
  // ignore: prefer_typing_uninitialized_variables
  final onWillPop;

  // ignore: use_key_in_widget_constructors
  const HeaderPage(
      {Key? key,
      this.bgColor,
      this.title,
      this.itemColor,
      this.actions,
      this.titleColor,
      this.onWillPop,
      this.noCallPop = false,
      this.noBack = false,
      this.isBackToHome = false});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 35,
        left: -20,
        right: 15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                !noBack
                    ? SizedBox(
                        width: 60,
                        height: 38,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.only(left: 15),
                            backgroundColor: bgColor ?? ColorsCustom.primary,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                          ),
                          onPressed: () {
                            noCallPop
                                ? null
                                : isBackToHome
                                    ? Navigator.pushNamedAndRemoveUntil(
                                        context, "/Layout", (route) => false)
                                    : Navigator.pop(context);
                            onWillPop != null ? onWillPop() : null;
                          },
                          child: Icon(
                            isBackToHome ? Icons.close : Icons.arrow_back,
                            color: itemColor ?? Colors.white,
                            size: 20,
                          ),
                        ))
                    : const SizedBox(),
                !noBack
                    ? const SizedBox(width: 15)
                    : const SizedBox(
                        width: 30,
                      ),
                title != null
                    ? CustomText(title,
                        color: titleColor ?? ColorsCustom.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16)
                    : const SizedBox(),
              ],
            ),
            actions != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: actions ?? [])
                : const SizedBox()
          ],
        ));
  }
}
