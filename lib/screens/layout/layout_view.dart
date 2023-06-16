import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../constants/enum/route_enum.dart';
import '../../helpers/helpers.dart';
import '../../redux/app_state.dart';
import '../../redux/modules/main_state.dart';
import './layout_view_model.dart';

class LayoutView extends LayoutViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StoreConnector<AppState, MainState>(
            converter: (store) => store.state.mainState,
            builder: (context, state) {
              return Stack(children: [
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: getScreens(state.layoutIndexScreen!),
                ),
                Positioned(
                    left: 10,
                    right: 10,
                    bottom: 10,
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: ColorsCustom.black),
                      child: Row(
                        children: listScreens
                            .map(
                              (e) => _bottomNavButton(
                                  index: e['index'],
                                  icon: e['icon'],
                                  current: state.layoutIndexScreen!),
                            )
                            .toList(),
                      ),
                    ))
              ]);
            }));
  }

  Widget _bottomNavButton(
      {required RouteEnum index,
      required RouteEnum current,
      required IconData icon}) {
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
                  color: current == index
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
                      color: current == index
                          ? ColorsCustom.white
                          : ColorsCustom.black),
                )
              ],
            )),
      ),
    );
  }
}
