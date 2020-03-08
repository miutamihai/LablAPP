import 'package:flutter/material.dart';
import 'custom_app_router.dart';
import 'package:labl_app/camera/camera_page.dart';
import 'package:labl_app/gallery/products_list.dart';
import 'package:labl_app/account/log_in.dart';
import 'nav_bar/tab_bar.dart';
import 'nav_bar/tab_item_icon.dart';

class BaseWidget extends StatefulWidget {
  final String pageToLoadId;

  const BaseWidget(this.pageToLoadId);
  @override
  _BaseWidgetState createState() => _BaseWidgetState(pageToLoadId);
}

class _BaseWidgetState extends State<BaseWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  String pageToLoadID;
  _BaseWidgetState(String ID) {
    this.pageToLoadID = ID;
    print(pageToLoadID);
  }

  int selectedIndex = 2;

  final iconList = [
    TabItemIcon(
      iconData: Icons.insert_photo,
      endColor: Colors.amber[50],
    ),
    TabItemIcon(
      iconData: Icons.camera,
      endColor: Colors.amber[50],
    ),
    TabItemIcon(
      iconData: Icons.settings,
      endColor: Colors.amber[50],
    ),
  ];
  void onChangeTab(int index) {
    selectedIndex = index;
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    print(pageToLoadID);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: iconList.length,
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[ProductList(), CameraPage(), LogIn()],
        ),
        bottomNavigationBar: JumpingTabBar(
          onChangeTab: onChangeTab,
          circleGradient: LinearGradient(
            colors: [
              Colors.amberAccent,
              Colors.amber,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          items: iconList,
          selectedIndex: selectedIndex,
        ),
      ),
    );
  }
}
