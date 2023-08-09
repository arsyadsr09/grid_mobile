import 'package:flutter/material.dart';

import '../helpers/helpers.dart';
import 'custom_text.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.suffix,
      required this.preffix,
      required this.name,
      this.onClick});

  final Widget suffix, preffix;
  final String name;
  final void Function(String)? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick!(name),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: const Offset(4, 0),
              blurRadius: 12,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.1))
        ], color: ColorsCustom.white, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  preffix,
                  const SizedBox(width: 15),
                  CustomText(
                    name,
                    color: ColorsCustom.black,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            suffix
          ],
        ),
      ),
    );
  }
}
