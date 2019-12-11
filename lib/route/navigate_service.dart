import 'package:flutter/material.dart';

class NavigateService {
  final GlobalKey<NavigatorState> globalKey = GlobalKey(debugLabel: 'navigate_key');

  NavigatorState get navigator => globalKey.currentState;

  get pushNamed => navigator.pushNamed;
  get push => navigator.push;
  get popAndPushNamed => navigator.popAndPushNamed;
}