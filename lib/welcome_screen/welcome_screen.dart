import 'package:labl_app/navigation/base_widget.dart';
import 'package:dashed_circle/dashed_circle.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:labl_app/navigation/custom_app_router.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  AnimationController _revealController;
  AnimationController _dotRotationController;
  AnimationController _textFadeController;
  AnimationController _titleFadeController;
  Animation _textFadeAnimation;
  Animation _titleFadeAnimation;
  Animation _dotRotationAnimation;
  Animation _revealAnimation;
  Animation _dotRotationGap;
  Animation _invertedAnimation;
  String _logoAnimation;

  Future goToHeroPage() async {
    await new Future.delayed(const Duration(milliseconds: 1000));
    Navigator.of(context).push(
        new AppPageRoute(builder: (BuildContext context) => new BaseWidget(2)));
  }

  @override
  void initState() {
    _logoAnimation = 'Idle Empty';
    _titleFadeController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _textFadeController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _textFadeAnimation =
        CurvedAnimation(parent: _textFadeController, curve: Curves.easeOut);
    _titleFadeAnimation =
    CurvedAnimation(parent: _titleFadeController, curve: Curves.easeOut)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _logoAnimation = 'Shrink';
          });
          goToHeroPage();
          _textFadeController.reverse();
          _dotRotationController.reset();
          _revealController.reverse();
        }
      });
    _dotRotationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _dotRotationAnimation =
    CurvedAnimation(parent: _dotRotationController, curve: Curves.easeInOut)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed &&
            status != AnimationStatus.reverse) {
          _dotRotationController.reverse();
          _textFadeController.forward();
          _titleFadeController.forward();
          _dotRotationController.reverse().whenComplete(() {
            setState(() {
              _logoAnimation = 'Idle Full';
            });
          });
        }
      });
    _invertedAnimation =
        Tween<double>(begin: 0.0, end: -1.0).animate(_dotRotationAnimation);
    _dotRotationGap =
        Tween<double>(begin: 5.0, end: 0.0).animate(_dotRotationAnimation);
    _revealController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _revealAnimation =
    CurvedAnimation(parent: _revealController, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed &&
            status != AnimationStatus.reverse) {
          setState(() {
            _logoAnimation = 'Grow';
          });
          _dotRotationController.forward();
        }
      });
    _revealController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _revealController.dispose();
    _dotRotationController.dispose();
    _textFadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: FadeTransition(
                    opacity: _titleFadeAnimation,
                    child: Hero(
                      tag: 'app_title',
                      child: Text(
                        '~LABL~',
                        style: TextStyle(fontSize: 40, color: Colors.white70, fontFamily: 'Acme', decoration: TextDecoration.none),
                      ),
                    ),
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularRevealAnimation(
                        animation: _revealAnimation,
                        minRadius: 0,
                        maxRadius: 70,
                        child: RotationTransition(
                            turns: _dotRotationAnimation,
                            child: DashedCircle(
                              gapSize: _dotRotationGap.value,
                              dashes: 10,
                              color: Colors.white70,
                              child: RotationTransition(
                                turns: _invertedAnimation,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.white70,
                                    child: FlareActor(
                                      'assets/animations/AnimatedLogo.flr',
                                      animation: _logoAnimation,
                                    ),
                                  ),
                                ),
                              ),
                            )))
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: FadeTransition(
                  opacity: _textFadeAnimation,
                  child: Text(
                    'The dating app \n for beers  	🍻',
                    style: TextStyle(fontSize: 30, color: Colors.white70),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
