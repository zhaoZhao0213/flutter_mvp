import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VEmptyView extends StatelessWidget {
  double height;
  Color backgroundColor;

  VEmptyView(double height, {Color backgroundColor}) {
    this.height = height;
    this.backgroundColor = backgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setWidth(height),
      decoration: BoxDecoration(color: backgroundColor ?? Colors.transparent),
    );
  }
}
