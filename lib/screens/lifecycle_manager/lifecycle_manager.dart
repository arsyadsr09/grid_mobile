import 'package:flutter/material.dart';
import './lifecycle_manager_view.dart';

class LifecycleManager extends StatefulWidget {
  const LifecycleManager({super.key, required this.child});

  final Widget child;

  @override
  LifecycleManagerView createState() => LifecycleManagerView();

  static LifecycleManagerView? of(BuildContext context) =>
      context.findAncestorStateOfType<LifecycleManagerView>();
}
