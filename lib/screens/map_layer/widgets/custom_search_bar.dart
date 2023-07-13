import 'package:flutter/material.dart';
import 'package:grid_mobile/screens/map_layer/widgets/result_search.dart';

import '../../../helpers/helpers.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar(
      {super.key,
      required this.controller,
      required this.color,
      this.readOnly = false,
      this.hint = "",
      this.onChange,
      required this.isResultShow,
      required this.data});

  final TextEditingController controller;
  final Color color;
  final bool readOnly, isResultShow;
  final String hint;
  final List<Map> data;
  final void Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        const SizedBox(
          height: 320,
        ),
        Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: ResultSearch(
              isResultShow: isResultShow,
              data: data,
            )),
        Container(
          height: 45,
          width: screenSize.width,
          margin: const EdgeInsets.only(bottom: 30),
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
              color: ColorsCustom.white,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(4, 0),
                    blurRadius: 12,
                    spreadRadius: 0,
                    color: Colors.black.withOpacity(0.1))
              ]),
          child: TextField(
            style: TextStyle(
                fontSize: 13,
                color: ColorsCustom.black,
                fontWeight: FontWeight.w400,
                height: 1.3,
                fontFamily: 'Poppins'),
            controller: controller,
            onChanged: (value) => onChange!(value),
            cursorHeight: 16,
            textAlignVertical: TextAlignVertical.top,
            cursorColor: color,
            readOnly: readOnly,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                size: 22,
                color: color,
              ),
              focusColor: color,
              hoverColor: color,
              fillColor: color,
              contentPadding: const EdgeInsets.only(top: 12),
              hintText: hint,
              hintStyle: TextStyle(
                  fontSize: 13,
                  color: const Color(0xFF9D9D9D).withOpacity(0.6),
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                  fontFamily: 'Poppins'),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
