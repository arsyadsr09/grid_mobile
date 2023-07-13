import 'package:flutter/material.dart';

import '../helpers/helpers.dart';
import 'custom_text.dart';

class CustomDropdown extends StatefulWidget {
  final String name;
  final List dataList;
  final String value;
  final bool noPaddingRight;
  final double borderRadius;
  final void Function(String)? onChange;

  const CustomDropdown(
      {Key? key,
      required this.name,
      required this.dataList,
      this.onChange,
      required this.value,
      this.noPaddingRight = false,
      this.borderRadius = 4})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomDropdown createState() => _CustomDropdown();
}

class _CustomDropdown extends State<CustomDropdown> {
  String? _selectedName;
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      padding: widget.noPaddingRight
          ? const EdgeInsets.only(left: 15)
          : const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: const Color(0xFFEAEEF1)),
      child: DropdownButton(
        value: widget.value,
        isExpanded: true,
        hint: CustomText(
          _selectedName ?? widget.name,
          color: isSelected ? ColorsCustom.black : const Color(0xff737576),
          fontWeight: isSelected ? FontWeight.normal : FontWeight.bold,
          fontSize: isSelected ? 14 : 12,
        ),
        items: widget.dataList.map((data) {
          return DropdownMenuItem(
            value: data.toString(),
            onTap: () {
              setState(() {
                _selectedName = data.toString();
                isSelected = true;
              });
            },
            child: CustomText(data.toString(),
                color: ColorsCustom.black,
                fontWeight: FontWeight.w600,
                fontSize: 12),
          );
        }).toList(),
        onChanged: (value) => widget.onChange!(value!),
        underline: const SizedBox(),
      ),
    );
  }
}
