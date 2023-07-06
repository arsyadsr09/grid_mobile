import 'package:flutter/material.dart';

import '../helpers/helpers.dart';
import 'custom_text.dart';

class HeaderPage extends StatelessWidget {
  final Color? bgColor, itemColor, titleColor;
  final String? title;
  final List<Widget>? actions;
  final bool isTransaction;
  final bool noCallPop, noBack;
  // ignore: prefer_typing_uninitialized_variables
  final onWillPop;

  // ignore: use_key_in_widget_constructors
  const HeaderPage({
    Key? key,
    this.bgColor,
    this.title,
    this.itemColor,
    this.actions,
    this.isTransaction = false,
    this.titleColor,
    this.onWillPop,
    this.noCallPop = false,
    this.noBack = false,
  });

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Positioned(
        top: 50,
        left: -10,
        right: 15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                !noBack
                    ? SizedBox(
                        width: 60,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: bgColor ?? ColorsCustom.primary,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                          ),
                          onPressed: () {
                            noCallPop ? null : Navigator.pop(context);
                            onWillPop != null ? onWillPop() : null;
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: itemColor ?? Colors.white,
                            size: 24,
                          ),
                        ))
                    : const SizedBox(),
                !noBack
                    ? const SizedBox(width: 20)
                    : const SizedBox(
                        width: 30,
                      ),
                title != null
                    ? CustomText(title,
                        color: titleColor ?? ColorsCustom.black,
                        fontWeight: FontWeight.w600,
                        fontSize: isTransaction ? width * 0.052 : 20)
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
