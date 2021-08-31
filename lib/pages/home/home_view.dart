import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_logic.dart';
import 'home_state.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final logic = Get.find<HomeLogic>();
  final HomeState state = Get.find<HomeLogic>().state;

  @override
    Widget build(BuildContext context) {
      return Container();
    }

  @override
  void dispose() {
    Get.delete<HomeLogic>();
    super.dispose();
  }
}