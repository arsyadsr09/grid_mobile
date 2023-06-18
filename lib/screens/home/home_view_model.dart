import 'package:flutter/material.dart';
import './home.dart';

abstract class HomeViewModel extends State<Home> {
  late ScrollController scrollController;
  double scrollPosition = 0.0;

  void _scrollListener() {
    setState(() {
      scrollPosition = scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
