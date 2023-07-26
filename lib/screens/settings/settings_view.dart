import 'package:flutter/material.dart';
import 'package:grid_mobile/widgets/widgets.dart';
import './settings_view_model.dart';

class SettingsView extends SettingsViewModel {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText('Settings'),
            ListTile(
              onTap: onLogOut,
              title: const CustomText("Sign Out"),
            )
          ],
        ),
      ),
    );
  }
}
