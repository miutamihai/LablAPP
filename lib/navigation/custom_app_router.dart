import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

Tween<Offset> GetBottomUpTween(){
  return Tween<Offset>(
    begin: const Offset(0.0, 1.0),
    end: Offset.zero,
  );
}

Tween<Offset> GetRightMiddleTween(bool shouldGoToTheRight){
  print(shouldGoToTheRight);
  Offset offset = (shouldGoToTheRight ? Offset(1.0, 0.0) : Offset(-1.0, 0.0));
  //Offset offset = Offset(1.0, 0.0);
  return Tween<Offset>(
    begin: offset,
    end: Offset.zero,
  );
}


// Offset from offscreen below to fully on screen.
class AppPageRoute extends MaterialPageRoute<String> {

  final bool shouldGoToTheRight;

  @override
  final bool maintainState;

  @override
  final WidgetBuilder builder;
  CupertinoPageRoute<String> _internalCupertinoPageRoute;

  AppPageRoute({
    @required this.shouldGoToTheRight,
    @required this.builder,
    RouteSettings settings: const RouteSettings(),
    this.maintainState: true,
    bool fullscreenDialog: false,
  })  : assert(builder != null),
        assert(settings != null),
        assert(maintainState != null),
        assert(fullscreenDialog != null),
        super(
        settings: settings,
        fullscreenDialog: fullscreenDialog,
        builder: builder,
      ) {
    assert(opaque); // PageRoute makes it return true.
  }

  @override
  Color get barrierColor => null;

  @override
  Duration get transitionDuration => const Duration(seconds: 2);

  CupertinoPageRoute<String> get _cupertinoPageRoute {
    assert(_useCupertinoTransitions);
    _internalCupertinoPageRoute ??= new CupertinoPageRoute<String>(
      builder: builder,
      fullscreenDialog: fullscreenDialog,
    );
    return _internalCupertinoPageRoute;
  }

  bool get _useCupertinoTransitions {
    return _internalCupertinoPageRoute?.popGestureInProgress == true ||
        Theme.of(navigator.context).platform == TargetPlatform.iOS;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    final Widget result = builder(context);
    assert(() {
      if (result == null) {
        throw new FlutterError('The builder for route "${settings.name}" returned null.\n'
            'Route builders must never return null.');
      }
      return true;
    }());
    return result;
  }

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    if (_useCupertinoTransitions) {
      return _cupertinoPageRoute.buildTransitions(context, animation, secondaryAnimation, child);
    }

    return new _CustomPageTransition(routeAnimation: animation, child: child, fullscreenDialog: fullscreenDialog, shouldGoToTheRight: shouldGoToTheRight,);
  }
}

// ignore: must_be_immutable
class _CustomPageTransition extends StatelessWidget {
  Animation<Offset> _positionAnimation;
  final Widget child;
  final bool fullscreenDialog;
  final bool shouldGoToTheRight;

  _CustomPageTransition({
    Key key,
    @required Animation<double> routeAnimation,
    @required this.child,
    @required this.fullscreenDialog, this.shouldGoToTheRight,
  })  {
    _positionAnimation = !fullscreenDialog ?
    GetRightMiddleTween(this.shouldGoToTheRight).animate(new CurvedAnimation(
      parent: routeAnimation,
      curve: Curves.elasticIn,
    ))
        : GetBottomUpTween().animate(new CurvedAnimation(
      parent: routeAnimation, // The route's linear 0.0 - 1.0 animation.
      curve: Curves.elasticIn,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new SlideTransition(
      position: _positionAnimation,
      child: child,
    );
  }
}