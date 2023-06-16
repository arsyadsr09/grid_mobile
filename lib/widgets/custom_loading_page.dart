import 'package:flutter/material.dart';
import 'package:grid_mobile/helpers/colors_custom.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoadingPage extends StatelessWidget {
  const CustomLoadingPage({super.key, required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return isLoading
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
  }
}
