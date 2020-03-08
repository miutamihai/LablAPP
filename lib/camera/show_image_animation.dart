import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'camera_page.dart';
import 'package:labl_app/navigation/custom_app_router.dart';
import '../show_results/show_results.dart';

enum AnimationToPlay { Activate, Deactivate, CameraTapped, ImageTapped }

class AcceptOrRepeat extends StatefulWidget {
  final image;

  const AcceptOrRepeat({Key key, @required this.image}) : super(key: key);
  @override
  _AcceptOrRepeatState createState() => _AcceptOrRepeatState(image);
}

class _AcceptOrRepeatState extends State<AcceptOrRepeat> with SingleTickerProviderStateMixin {
  _AcceptOrRepeatState(this.image);

  Future goToCamera() async {
    await new Future.delayed(const Duration(milliseconds: 100));
    Navigator.of(context).push(
        new AppPageRoute(builder: (BuildContext context) => new CameraPage()));
  }

  final FlareControls animationControls = FlareControls();
  String function;
  final image;


  AnimationToPlay _animationToPlay = AnimationToPlay.Activate;
  AnimationToPlay _lastAnimationPlayed;

  static const double AnimationWidth = 295.0;
  static const double AnimationHeight = 251.0;
  bool isOpen = false;
  bool shouldTakePicture = false;

  @override
  void initState(){
    super.initState();
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
                goToCamera();
              }else if(rightSideTouched && topHalfTouched){
                _setAnimationToPlay(AnimationToPlay.ImageTapped);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ShowResult(image: image)),
                );
              }else if (isOpen) {
                _setAnimationToPlay(AnimationToPlay.Deactivate);
              } else
                _setAnimationToPlay(AnimationToPlay.Activate);

              isOpen = !isOpen;
            });
          },
          child: FlareActor(
            'assets/animations/AcceptOrCancel.flr',
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

    _lastAnimationPlayed = animation;
  }
}
