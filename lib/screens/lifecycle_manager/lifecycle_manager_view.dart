import 'package:flutter/material.dart';
import './lifecycle_manager_view_model.dart';
  
class LifecycleManagerView extends LifecycleManagerViewModel {
    
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

