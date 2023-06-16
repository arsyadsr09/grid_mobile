import 'package:flutter/material.dart';
import 'package:grid_mobile/helpers/colors_custom.dart';
import 'package:grid_mobile/widgets/custom_text.dart';

class ErrorForm extends StatelessWidget {
  const ErrorForm({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 5),
      child: CustomText(
        error,
        fontWeight: FontWeight.w300,
        fontSize: 14,
        color: ColorsCustom.primary,
      ),
    );
  }
}
