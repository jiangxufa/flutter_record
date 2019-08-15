import 'package:flutter/material.dart';
import 'package:flutter_demo/feixiu/animat/berzier/bezier_matrix4_tween.dart';

class BezierAnimationContainer extends StatefulWidget {
  final BezierAnimationContainerCallBack bezierAnimationContainerCallBack;
  final Widget child;
  final Matrix4 start;
  final Matrix4 end;
  final Duration duration;

  BezierAnimationContainer(
      this.bezierAnimationContainerCallBack, this.child, this.start, this.end,
      {this.duration: const Duration(milliseconds: 3000)});

  @override
  State<StatefulWidget> createState() {
    return BezierAnimationContainerState();
  }
}

class BezierAnimationContainerState extends State<BezierAnimationContainer>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var bezierMatrix4Tween;
  var animation;
  bool isHint = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    bezierMatrix4Tween =
        new BezierMatrix4Tween(begin: widget.start, end: widget.end);
    animation = bezierMatrix4Tween.animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((state) {
        switch (state) {
          case AnimationStatus.dismissed:
            break;
          case AnimationStatus.forward:
            isHint = false;
            widget.bezierAnimationContainerCallBack.onAnimationStart();
            break;
          case AnimationStatus.reverse:
            break;
          case AnimationStatus.completed:
            isHint = true;
            widget.bezierAnimationContainerCallBack.onAnimationEnd();
            break;
        }
      });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        child: Transform(
          transform: animation.value,
          child: Offstage(
            offstage: isHint,
            child: Container(child: widget.child),
          ),
        ));
  }
}

abstract class BezierAnimationContainerCallBack {
  void onAnimationStart();

  void onAnimationEnd();
}
