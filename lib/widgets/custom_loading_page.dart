import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:grid_mobile/helpers/colors_custom.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../redux/app_state.dart';
import '../redux/modules/main_state.dart';

class CustomLoadingPage extends StatelessWidget {
  const CustomLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MainState>(
        converter: (store) => store.state.mainState,
        builder: (context, state) {
          return state.isLoading
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white70,
                  alignment: Alignment.center,
                  child: LoadingAnimationWidget.halfTriangleDot(
                    color: ColorsCustom.primary,
                    size: 100,
                  ),
                )
              : const SizedBox();
        });
  }
}
