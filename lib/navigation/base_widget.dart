import 'package:flutter/material.dart';
import 'package:labl_app/camera/camera_page.dart';
import 'package:labl_app/gallery/products_list.dart';
import 'package:labl_app/account/log_in.dart';
import 'nav_bar/tab_bar.dart';
import 'nav_bar/tab_item_icon.dart';

class BaseWidget extends StatefulWidget {
  final int selectedIndex;

  const BaseWidget(this.selectedIndex);
  @override
  _BaseWidgetState createState() => _BaseWidgetState(selectedIndex);
}

class _BaseWidgetState extends State<BaseWidget>
    with SingleTickerProviderStateMixin {
  final GlobalKey<CameraScreenstate> _cameraKey = GlobalKey<CameraScreenstate>();
  Widget _cameraPage;
  Widget _galleryPage;
  Widget _accountPage;
  AnimationController _controller;
  int selectedIndex = 2;
  _BaseWidgetState(int ID) {
    this.selectedIndex = ID;
  }

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
    if(selectedIndex == index && index == 2){
      _cameraKey.currentState.onCapturePressed();
    }
    selectedIndex = index;
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _cameraPage = CameraPage(key: _cameraKey,);
    _galleryPage = ProductList();
    _accountPage  = LogIn();
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(44),
          child: AppBar(
            centerTitle: true,
            title: Hero(
              tag: 'app_title',
              child: Text(
                '~LABL~',
                style: TextStyle(fontSize: 40, fontFamily: 'Acme', decoration: TextDecoration.none, color: Colors.white70),
              ),
            ),
            backgroundColor: Colors.amber,
            automaticallyImplyLeading: false,
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _galleryPage,
            _cameraPage,
            _accountPage
          ],
        ),
        bottomNavigationBar: JumpingTabBar(
          duration: Duration(seconds: 1),
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
