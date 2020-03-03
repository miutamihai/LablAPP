import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:compare_that_price/widgets/camera_page.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:dashed_circle/dashed_circle.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';

class WelcomeSplashScreen extends StatefulWidget {
  @override
  _WelcomeSplashScreenState createState() => _WelcomeSplashScreenState();
}

class _WelcomeSplashScreenState extends State<WelcomeSplashScreen>
    with TickerProviderStateMixin {
  AnimationController dot_rotation_controller;
  AnimationController reveal_controller;
  AnimationController text_fade_controller;
  Animation<double> reveal_animation;
  Animation dots_rotation_base;
  Animation inverted;
  Animation gap;
  Animation text_opacity;
  String logo_animation;
  bool animation_played = false;


  @override
  void initState() {
    super.initState();
    logo_animation = 'Idle Empty';
    text_fade_controller =
      AnimationController(vsync: this, duration: Duration(seconds: 1));
    dot_rotation_controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    dots_rotation_base =
        CurvedAnimation(parent: dot_rotation_controller, curve: Curves.easeOut)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed && status != AnimationStatus.reverse) {
              setState(() {
                logo_animation = 'Idle Full';
              });
              dot_rotation_controller.reverse().whenComplete(() {
                setState(() {
                  //logo_animation = 'Shrink';
                });
              });
            }
          });

    text_opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(text_fade_controller)
    ..addStatusListener((status) {
      if(status == AnimationStatus.completed && status != AnimationStatus.reverse){
        text_fade_controller.reverse();
        setState(() {
          logo_animation = 'Shrink';
        });
        text_fade_controller.reverse().whenComplete(() {
          logo_animation = 'Idle Empty';
          reveal_controller.reverse();
        });
      }
    });

    inverted = Tween<double>(begin: 0.0, end: -1.0).animate(dots_rotation_base)
      ..addListener(() {
        setState(() {});
      });

    gap = Tween<double>(begin: 5.0, end: 0.0).animate(dots_rotation_base)
      ..addListener(() {
        setState(() {});
      });
    reveal_controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    reveal_animation =
        CurvedAnimation(parent: reveal_controller, curve: Curves.easeIn)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed && status != AnimationStatus.reverse)
              {
                setState(() {
                  logo_animation = 'Grow';
                });
                dot_rotation_controller.forward();
                text_fade_controller.forward();
              }
          });
    reveal_controller.forward();
  }

  @override
  void dispose() {
    dot_rotation_controller.dispose();
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
                  opacity: text_opacity,
                  child: Text(
                    '~LABL~',
                    style: TextStyle(fontSize: 40),
                  ),
                )
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularRevealAnimation(
                      animation: reveal_animation,
                      minRadius: 0,
                      maxRadius: 70,
                      child: RotationTransition(
                        turns: dots_rotation_base,
                        child: DashedCircle(
                          gapSize: gap.value,
                          dashes: 20,
                          color: Colors.white70,
                          child: RotationTransition(
                            turns: inverted,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CircleAvatar(
                                radius: 60.0,
                                child: FlareActor(
                                  'assets/animations/AnimatedLogo.flr',
                                  animation: logo_animation,
                                ),
                                backgroundColor: Colors.white70,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: FadeTransition(
                  opacity: text_opacity,
                  child: Text(
                    'The dating app \n for beers  	🍻',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
