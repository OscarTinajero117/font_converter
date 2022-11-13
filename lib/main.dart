import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/modules/home/bindings.dart';
import 'app/modules/home/page.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.light(),
    defaultTransition: Transition.fade,
    initialBinding: HomeBinding(),
    home: const HomePage(),
  ));
}
