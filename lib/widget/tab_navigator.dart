import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mvp/pages/tab1/tab1.dart';
import 'package:flutter_mvp/pages/tab2/tab2.dart';
import 'package:flutter_mvp/pages/tab3/tab3.dart';
import 'package:flutter_mvp/pages/tab4/tab4.dart';

class TabNavigator extends StatefulWidget {
  @override
  TabNavigatorState createState() => TabNavigatorState();
}

class TabNavigatorState extends State<TabNavigator>
    with AutomaticKeepAliveClientMixin {
  final PageController _pageController = PageController(initialPage: 0);
  final _defaultColor = Colors.black;
  final _activeColor = Color(0xFF00A0E9);
  int _currentIndex = 0;
  TabPage1 _tabPage1 = TabPage1();
  TabPage2 _tabPage2 = TabPage2();
  TabPage3 _tabPage3 = TabPage3();
  TabPage4 _tabPage4 = TabPage4();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: <Widget>[
          _tabPage1,
          _tabPage2,
          _tabPage3,
          _tabPage4,
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.jumpToPage(index);
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(_currentIndex != 0
                  ? 'assets/images/shoukuan_normal.png'
                  : 'assets/images/shoukuan_selected.png'),
              title: Text(
                'tab1',
                style: TextStyle(
                    color: _currentIndex != 0 ? _defaultColor : _activeColor, fontSize: ScreenUtil().setSp(22)),
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(_currentIndex != 1
                  ? 'assets/images/zhangd_normal.png'
                  : 'assets/images/zhangd_selected.png'),
              title: Text(
                'tab2',
                style: TextStyle(
                    color: _currentIndex != 1 ? _defaultColor : _activeColor, fontSize: ScreenUtil().setSp(22)),
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(_currentIndex != 2
                  ? 'assets/images/juke_normal.png'
                  : 'assets/images/juke_selected.png'),
              title: Text(
                'tab3',
                style: TextStyle(
                    color: _currentIndex != 2 ? _defaultColor : _activeColor, fontSize: ScreenUtil().setSp(22)),
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(_currentIndex != 3
                  ? 'assets/images/set_normal.png'
                  : 'assets/images/set_selected.png'),
              title: Text(
                'tab4',
                style: TextStyle(
                    color: _currentIndex != 3 ? _defaultColor : _activeColor, fontSize: ScreenUtil().setSp(22)),
              ),
            ),
          ],
        ),
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}
