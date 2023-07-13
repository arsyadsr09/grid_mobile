import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grid_mobile/widgets/custom_text.dart';

import '../helpers/colors_custom.dart';
import '../utils/formatter_phone.dart';
import 'error_form_text.dart';

class FormText extends StatefulWidget {
  final TextEditingController controller;
  final String hint, idError;
  final String? errorMessage;
  final Widget? suffix, preffix;
  final TextInputType? keyboard;
  final bool obscureText, readOnly, capitalize, phone, withClear, hideLabel;
  final Color? fontColor, iconColor;
  final void Function(String)? onChange, onClear;

  const FormText(
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
      this.phone = false,
      this.hideLabel = false,
      this.errorMessage,
      required this.idError,
      this.suffix,
      this.preffix,
      this.withClear = false,
      this.onClear});
  @override
  // ignore: library_private_types_in_public_api
  _FormTextState createState() => _FormTextState();
}

class _FormTextState extends State<FormText> {
  bool obscureMode = true;
  FocusNode focusNode = FocusNode();

  void toggleObsecure() {
    setState(() {
      obscureMode = !obscureMode;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.hideLabel
              ? const SizedBox()
              : widget.errorMessage != "" && widget.controller.text.isEmpty
                  ? ErrorForm(error: widget.errorMessage!)
                  : CustomText(
                      widget.hint,
                      color: ColorsCustom.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
          widget.hideLabel ? const SizedBox() : const SizedBox(height: 7),
          Container(
              height: 50,
              padding: widget.preffix != null
                  ? const EdgeInsets.fromLTRB(5, 3, 5, 0)
                  : const EdgeInsets.fromLTRB(16, 3, 5, 0),
              decoration: BoxDecoration(
                  color: ColorsCustom.cloud,
                  borderRadius: BorderRadius.circular(12)),
              child: TextField(
                focusNode: focusNode,
                style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: widget.fontColor ?? ColorsCustom.black,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Poppins"),
                controller: widget.controller,
                keyboardType: widget.keyboard,
                readOnly: widget.readOnly,
                onChanged: (_) => widget.onChange!(widget.idError),
                onTap: () => widget.onChange!(widget.idError),
                // cursorHeight: 22,
                cursorColor: widget.iconColor,
                obscureText: widget.obscureText && obscureMode,
                textCapitalization: widget.capitalize
                    ? TextCapitalization.words
                    : TextCapitalization.none,
                inputFormatters: widget.phone
                    ? [
                        FilteringTextInputFormatter.digitsOnly,
                        CustomInputFormatter()
                      ]
                    : null,
                decoration: InputDecoration(
                  prefixIcon: widget.preffix,
                  suffixIcon: widget.withClear &&
                          focusNode.hasFocus &&
                          widget.controller.text.isNotEmpty
                      ? GestureDetector(
                          onTap: () => widget.onClear!(widget.idError),
                          child: Icon(
                            Icons.close_rounded,
                            size: 18,
                            color: ColorsCustom.black,
                          ),
                        )
                      : widget.suffix ??
                          (widget.obscureText
                              ? obscureMode
                                  ? GestureDetector(
                                      onTap: () => toggleObsecure(),
                                      child: const Icon(
                                        CupertinoIcons.eye_slash_fill,
                                        size: 18,
                                      ))
                                  : GestureDetector(
                                      onTap: () => toggleObsecure(),
                                      child: const Icon(
                                        CupertinoIcons.eye_fill,
                                        size: 18,
                                      ))
                              : const SizedBox()),
                  focusColor: widget.iconColor ?? ColorsCustom.black,
                  hoverColor: widget.iconColor ?? ColorsCustom.black,
                  hintText: widget.hint,
                  hintStyle: TextStyle(
                      height: focusNode.hasFocus ||
                              widget.controller.text.isNotEmpty
                          ? 0.3
                          : 2,
                      color: widget.errorMessage != ""
                          ? ColorsCustom.primary
                          : const Color(0xFFA1A4A8),
                      fontWeight: FontWeight.w300),
                  border: InputBorder.none,
                ),
              )),
        ],
      ),
    );
  }
}
