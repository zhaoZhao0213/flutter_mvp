import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HEmptyView extends StatelessWidget {
  final double width;

  HEmptyView(this.width);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: ScreenUtil().setWidth(width),);
  }
}
