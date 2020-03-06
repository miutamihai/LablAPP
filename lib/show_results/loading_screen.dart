import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  final FlareControls controls = FlareControls();
  String _animation = 'Play';

  void _playSuccessAnimation() {
    // Use the controls to trigger an animation.
    controls.play('Play');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: FlareActor('assets/animations/LogoLoadingScreen.flr',
          animation: _animation,
          fit: BoxFit.contain,
          alignment: Alignment.center,
          callback: (string) {
            setState(() {
              _animation = 'Play';
            });
          },
          // Make sure you use the controls with the Flare Actor widget.
          controller: controls),
    );
  }
}
