import 'package:flutter/material.dart';
import 'package:flutter_mvp/app/application.dart';
import 'package:flutter_mvp/widget/tab_navigator.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{

  @override
  Widget build(BuildContext context) {
    Application.initScreenUtil(context);
    return TabNavigator();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}