import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

import '../helpers/colors_custom.dart';
import 'custom_text.dart';

class FormAmount extends StatefulWidget {
  final TextEditingController controller;
  final String? hint, preffix, suffix;
  final TextInputType? keyboard;
  final bool obscureText, readOnly, capitalize;
  final Color? fontColor, iconColor;
  final void Function(String)? onChange, onClear;
  final void Function()? onTap;

  const FormAmount(
      {super.key,
      required this.controller,
      this.onChange,
      required this.hint,
      this.keyboard,
      this.fontColor,
      this.iconColor,
      this.obscureText = false,
      this.readOnly = false,
      this.capitalize = false,
      this.preffix,
      this.onTap,
      this.onClear,
      this.suffix});
  @override
  // ignore: library_private_types_in_public_api
  _FormAmountState createState() => _FormAmountState();
}

class _FormAmountState extends State<FormAmount> {
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 35,
        padding: const EdgeInsets.only(top: 6, right: 10, left: 10, bottom: 7),
        decoration: BoxDecoration(
            color: ColorsCustom.cloud, borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: [
            if (widget.preffix!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CustomText(
                  widget.preffix,
                  fontSize: 10,
                  color: ColorsCustom.disabled,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),
              ),
            Expanded(
              child: TextField(
                onTap: widget.controller.text == '0' ? widget.onTap : () {},
                focusNode: focusNode,
                style: TextStyle(
                    fontSize: 12,
                    color: widget.fontColor ?? ColorsCustom.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins"),
                controller: widget.controller,
                keyboardType: TextInputType.number,
                readOnly: widget.readOnly,
                cursorColor: widget.iconColor,
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    decimalDigits: 0,
                    symbol: "",
                  )
                ],
                maxLines: 1,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: -22),
                  border: InputBorder.none,
                ),
              ),
            ),
            if (widget.suffix!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CustomText(
                  widget.suffix,
                  fontSize: 10,
                  color: ColorsCustom.disabled,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ));
  }
}
