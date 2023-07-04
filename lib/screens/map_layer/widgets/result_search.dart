import 'package:flutter/material.dart';
import 'package:grid_mobile/helpers/colors_custom.dart';
import 'package:grid_mobile/widgets/custom_text.dart';

class ResultSearch extends StatefulWidget {
  const ResultSearch(
      {super.key, required this.isResultShow, required this.data});

  final bool isResultShow;
  final List<Map> data;

  @override
  State<ResultSearch> createState() => _ResultSearchState();
}

class _ResultSearchState extends State<ResultSearch> {
  static Map selectedDataDummy = {"id": "1", "name": "Hotel Sriwijaya Redo"};
  Map? selectedData;

  void onSelectLocation(Map selected) {
    setState(() {
      selectedData = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.maxFinite,
        constraints: BoxConstraints(maxHeight: widget.isResultShow ? 300 : 0),
        padding: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
            color: ColorsCustom.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(4, 0),
                  blurRadius: 12,
                  spreadRadius: 0,
                  color: Colors.black.withOpacity(0.15))
            ]),
        child: ListView(padding: EdgeInsets.zero, shrinkWrap: true, children: [
          listLocation(
              name: "Hotel Sriwijaya Redo",
              address: "Jl. Tumenggung Suryo No. 33, Ubud, Bali",
              data: selectedDataDummy),
          listLocation(
              name: "Hotel Padjajaran",
              address: "Jl. L.A. Sucipto No. 33, Lowokwaru, Malang",
              data: selectedDataDummy),
          listLocation(
              name: "Hotel Ibis Style",
              address: "Jl. L.A. Sucipto No. 33, Lowokwaru, Malang",
              data: selectedDataDummy),
        ]),
      ),
    );
  }

  Widget listLocation(
      {required String name, required String address, required Map data}) {
    return GestureDetector(
      onTap: () => selectedData,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 0.5, color: ColorsCustom.border))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    name,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    address,
                    fontSize: 10,
                    color: ColorsCustom.disabled,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            Icon(Icons.call_made,
                size: 18, color: ColorsCustom.disabled.withOpacity(0.7))
          ],
        ),
      ),
    );
  }
}
