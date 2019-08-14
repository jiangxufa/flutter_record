import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:vector_math/vector_math_64.dart';
import 'dart:collection';

class CarAnimatDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CarAnimatDemoState();
  }
}

class CarAnimatDemoState extends State<CarAnimatDemo>
    with SingleTickerProviderStateMixin {
  GlobalKey anchorKey = GlobalKey();
  String desc = '';

  Animation<double> _animation;
  AnimationController _controller;
  var fractionalOffsetTween;
  var animation;
  bool isShow = false;
  var bezierMatrix4Tween;
  List<AnimatPostionWidget> animatWidgets = List();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 5000),
      vsync: this,
    );
    _animation = Tween(begin: 1.0, end: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((state) {
        switch (state) {
          case AnimationStatus.dismissed:
            isShow = false;
            break;
          case AnimationStatus.forward:
            isShow = true;
            break;
          case AnimationStatus.reverse:
            isShow = true;
            break;
          case AnimationStatus.completed:
            isShow = false;
            break;
        }
      });
    bezierMatrix4Tween = new BezierMatrix4Tween(
        begin: Matrix4.translationValues(50, 60, 0),
        end: Matrix4.translationValues(300, 300, 0));
    animation = bezierMatrix4Tween.animate(_controller)
      ..addStatusListener((state) {
        switch (state) {
          case AnimationStatus.dismissed:
            isShow = false;
            break;
          case AnimationStatus.forward:
            isShow = true;
            break;
          case AnimationStatus.reverse:
            isShow = true;
            break;
          case AnimationStatus.completed:
            isShow = false;
            break;
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
              top: 60,
              left: 50,
              child: RaisedButton(
                onPressed: () {
                  _controller.reverse();
                },
                child: Text("点击"),
              )),
          Positioned(
              top: 60,
              left: 150,
              child: RaisedButton(
                key: anchorKey,
                onPressed: () {
                  getLocationInfo();
                },
                child: Text("返回"),
              )),
          Positioned(bottom: 20, left: 20, child: Text(desc)),
          isShow
              ? Positioned(
                  top: 0,
                  child: Transform(
                    transform: animation.value,
                    child: Container(
                        height: 50,
                        width: 50,
                        child: FlutterLogo(
                          size: 50,
                        )),
                  ))
              : Container(),
        ]..addAll(animatWidgets.map((animal) => animal.widget).toList()),
      ),
    );
  }

  getLocationInfo() {
    RenderBox renderBox = anchorKey.currentContext.findRenderObject();
    //左上角
    var offset = renderBox.localToGlobal(Offset.zero);
    setState(() {
      desc = "${offset.dx}    ${offset.dy}";
    });
    fractionalOffsetTween = FractionalOffsetTween(
            begin: FractionalOffset(offset.dx, offset.dy),
            end: FractionalOffset(100, 200))
        .animate(_controller);
    bezierMatrix4Tween.begin = Matrix4.translationValues(50, 50, 0);
//    addWidget();
    _controller.forward();
  }

  void addWidget() {
    var animate = new BezierMatrix4Tween(
        begin: Matrix4.translationValues(50, 60, 0),
        end: Matrix4.translationValues(300, 300, 0))
      ..animate(_controller).addStatusListener((state) {
        switch (state) {
          case AnimationStatus.dismissed:
            break;
          case AnimationStatus.forward:
            break;
          case AnimationStatus.reverse:
            break;
          case AnimationStatus.completed:
            animatWidgets.removeLast();
            break;
        }
      });

    var widget = Positioned(
        top: 0,
        child: Transform(
          transform: animation.value,
          child: Container(
              height: 50,
              width: 50,
              child: FlutterLogo(
                size: 50,
              )),
        ));

    animatWidgets.add(AnimatPostionWidget(widget, animate));
  }
}




class CarAnimatDemo1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CarAnimatDemoState1();
  }
}

class CarAnimatDemoState1 extends State<CarAnimatDemo1> with BezierAnimationContainerCallBack{

  GlobalKey anchorKey = GlobalKey();
//  List<Widget> animatWidgets = List();
  Queue<Widget> animatWidgets = Queue();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
              top: 60,
              left: 50,
              child: RaisedButton(
                onPressed: () {
                },
                child: Text("点击"),
              )),
          Positioned(
              top: 60,
              left: 150,
              child: RaisedButton(
                key: anchorKey,
                onPressed: () {
                  getLocationInfo();
                },
                child: Text("返回"),
              )),
        ]..addAll(animatWidgets.toList()),
      ),
    );
  }

  void getLocationInfo() {
    RenderBox renderBox = anchorKey.currentContext.findRenderObject();
    //左上角
    var offset = renderBox.localToGlobal(Offset.zero);
    animatWidgets.addFirst(BezierAnimationContainer(this));
    setState(() {
    });
  }

  @override
  void onAnimationEnd() {
    if(animatWidgets.length >0){
      animatWidgets.removeLast();
    }
    print("animatWidgets=${animatWidgets.length}");
  }

  @override
  void onAnimationStart() {
  }
}


class BezierAnimationContainer extends StatefulWidget {
  final BezierAnimationContainerCallBack bezierAnimationContainerCallBack;

  BezierAnimationContainer(this.bezierAnimationContainerCallBack);

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
      duration: Duration(milliseconds: 5000),
      vsync: this,
    );
    bezierMatrix4Tween = new BezierMatrix4Tween(
        begin: Matrix4.translationValues(50, 60, 0),
        end: Matrix4.translationValues(300, 300, 0));
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
          child:Offstage(offstage: isHint,child:  Container(
          height: 50,
          width: 50,
          child: FlutterLogo(
          size: 50,
          )),),
        ));
  }
}

abstract class BezierAnimationContainerCallBack {
  void onAnimationStart();

  void onAnimationEnd();
}

class AnimatPostionWidget {
  Widget widget;
  BezierMatrix4Tween animate;

  AnimatPostionWidget(this.widget, this.animate);
}

class BezierMatrix4Tween extends Matrix4Tween {
  BezierMatrix4Tween({Matrix4 begin, Matrix4 end})
      : super(begin: begin, end: end);

  @override
  Matrix4 lerp(double t) {
    assert(begin != null);
    assert(end != null);
    final Vector3 beginTranslation = Vector3.zero();
    final Vector3 endTranslation = Vector3.zero();
    final Quaternion beginRotation = Quaternion.identity();
    final Quaternion endRotation = Quaternion.identity();
    final Vector3 beginScale = Vector3.zero();
    final Vector3 endScale = Vector3.zero();
    begin.decompose(beginTranslation, beginRotation, beginScale);
    end.decompose(endTranslation, endRotation, endScale);
    final Vector3 lerpTranslation =
        _caculate(beginTranslation, endTranslation, t);
    // TODO(alangardner): Implement slerp for constant rotation
    final Quaternion lerpRotation =
        (beginRotation.scaled(1.0 - t) + endRotation.scaled(t)).normalized();
    final Vector3 lerpScale = beginScale * (1.0 - t) + endScale * t;
    return Matrix4.compose(lerpTranslation, lerpRotation, lerpScale);
  }

  Vector3 _caculate(
      Vector3 beginTranslation, Vector3 endTranslation, double t) {
    Vector3 controllPoint = Vector3((beginTranslation.x + endTranslation.x) / 2,
        (beginTranslation.y - 100), 0);
    double x = ((1 - t) * (1 - t) * beginTranslation.x +
        2 * t * (1 - t) * controllPoint.x +
        t * t * endTranslation.x);
    double y = ((1 - t) * (1 - t) * beginTranslation.y +
        2 * t * (1 - t) * controllPoint.y +
        t * t * endTranslation.y);
    return Vector3(x, y, 0);
  }
}
