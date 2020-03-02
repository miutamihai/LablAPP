import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'products_list.dart';
import 'camera_page.dart';

enum AnimationToPlay { Activate, Deactivate, CameraTapped, ImageTapped }

// ignore: must_be_immutable
class SmartFlareAnimation extends StatefulWidget {
  bool shouldTakePicture = false;
  @override
  _SmartFlareAnimationState createState() => _SmartFlareAnimationState();
}

class _SmartFlareAnimationState extends State<SmartFlareAnimation>
    with SingleTickerProviderStateMixin {
  final FlareControls animationControls = FlareControls();

  AnimationToPlay _animationToPlay = AnimationToPlay.Deactivate;
  AnimationToPlay _lastAnimationPlayed;

  static const double AnimationWidth = 295.0;
  static const double AnimationHeight = 251.0;
  bool isOpen = false;

  @override
  void initState(){
    super.initState();
    widget.shouldTakePicture = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: AnimationWidth,
        height: AnimationHeight,
        child: GestureDetector(
          onTapUp: (tapInfo) {
            setState(() {
              var localTouchPosition = (context.findRenderObject() as RenderBox)
                  .globalToLocal(tapInfo.globalPosition);

              var topHalfTouched = localTouchPosition.dy < AnimationHeight / 2;

              var leftSideTouched = localTouchPosition.dx < AnimationWidth / 2;
              var rightSideTouched = topHalfTouched && !leftSideTouched;

              if (leftSideTouched && topHalfTouched) {
                _setAnimationToPlay(AnimationToPlay.CameraTapped);
                if(! widget.shouldTakePicture){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CameraPage(),
                      ));
                }
              } else if (rightSideTouched) {
                _setAnimationToPlay(AnimationToPlay.ImageTapped);
                widget.shouldTakePicture = false;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductsList()));
              } else if (isOpen) {
                _setAnimationToPlay(AnimationToPlay.Deactivate);
              } else
                _setAnimationToPlay(AnimationToPlay.Activate);

              isOpen = !isOpen;
            });
          },
          child: FlareActor(
            'assets/animations/LablNavBarNoAccount.flr',
            animation: _getAnimationName(_animationToPlay),
            controller: animationControls,
          ),
        ));
  }

  String _getAnimationName(AnimationToPlay animationToPlay) {
    switch (animationToPlay) {
      case AnimationToPlay.Activate:
        return 'activate';
      case AnimationToPlay.Deactivate:
        return 'deactivate';
      case AnimationToPlay.CameraTapped:
        return 'camera_tapped';
      case AnimationToPlay.ImageTapped:
        return 'image_tapped';
      default:
        return 'deactivate';
    }
  }

  void _setAnimationToPlay(AnimationToPlay animation) {
    var isTappedAnimation = _getAnimationName(animation).contains('_tapped');

    if (isTappedAnimation &&
        _lastAnimationPlayed == AnimationToPlay.Deactivate) {
      return;
    }

    animationControls.play(_getAnimationName(animation));

    if(animation == AnimationToPlay.CameraTapped &&
        _lastAnimationPlayed == AnimationToPlay.CameraTapped){
        widget.shouldTakePicture = true;
    }

    _lastAnimationPlayed = animation;
  }
}
