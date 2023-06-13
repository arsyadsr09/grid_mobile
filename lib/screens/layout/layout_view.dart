import 'package:flutter/material.dart';
import 'package:grid_mobile/helpers/colors_custom.dart';
import './layout_view_model.dart';

class LayoutView extends LayoutViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
        ),
        Positioned(
            left: 10,
            right: 10,
            bottom: 10,
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: ColorsCustom.black),
              child: Row(
                children: listScreens
                    .map(
                      (e) =>
                          _bottomNavButton(index: e['index'], icon: e['icon']),
                    )
                    .toList(),
              ),
            ))
      ]),
    );
  }

  Widget _bottomNavButton({required int index, required IconData icon}) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setCurrentIndexScreen(index),
        child: SizedBox(
            height: 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 5),
                Icon(
                  icon,
                  color: isCurrentIndexScreen(index)
                      ? ColorsCustom.white
                      : ColorsCustom.disabled,
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 4,
                  height: 4,
                  margin: const EdgeInsets.only(top: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: isCurrentIndexScreen(index)
                          ? ColorsCustom.white
                          : ColorsCustom.black),
                )
              ],
            )),
      ),
    );
  }
}
