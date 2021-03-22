import 'package:flutter/material.dart';
//import 'package:ssepnew/themes.dart';
//
//class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
//  final Color backgroundColor = Colors.red;
//  final Text title;
//  final AppBar appBar;
//  final List<Widget> widgets;
//
//  /// you can add more fields that meet your needs
//
//  const BaseAppBar({Key key, this.title, this.appBar, this.widgets})
//      : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return AppBar(
//      title: title,
//      backgroundColor: backgroundColor,
//      actions: widgets,
//    );
//  }
//
//  @override
//  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
//}
class CustomAppBar extends PreferredSize {
  final Widget child;
  final double height;

  CustomAppBar({@required this.child, this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
//      color: Color.fromRGBO(45, 87, 163, 1),

//      alignment: Alignment.center,
      child: child,
    );


  }
}