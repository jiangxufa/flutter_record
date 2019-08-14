import 'package:flutter/material.dart';

/// https://wizardforcel.gitbooks.io/gsyflutterbook/content/Flutter-8.html
/// Margin 和 Padding不支持负数  需要使用 transform
class AnimatY extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AnimatYState();
  }
}

class AnimatYState extends State<AnimatY> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Matrix4> animation;
  Animation<double> doubleAnimation;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this)
      ..addListener(() {
        setState(() {
          //动画执行的时候 可以看法到疯狂的回调(用来刷新ui)
//          print("addListener");
        });
      })
      /// 使用forward  回调  forward->completed  使用reverse reverse->dismissed
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.dismissed:
            print("dismissed");
            break;
          case AnimationStatus.forward:
            print("forward");
            break;
          case AnimationStatus.reverse:
            print("reverse");
            break;
          case AnimationStatus.completed:
            print("completed");
            break;
        }
      });
    doubleAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation = new Matrix4Tween(
            begin: Matrix4.translationValues(0, 300, 0),
            end: Matrix4.translationValues(0, 0, 0))
        .animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: 700,
        child: Stack(
          children: <Widget>[
            FadeTransition(
              opacity: controller,
              child: GestureDetector(
                onTap: (){
                  controller.reverse();
                },
                child: Container(
                  color: Colors.grey,
                ),
              ),
            ),
            Positioned(
                bottom: 60,
                child: Transform(
                  transform: animation.value,
                  child: Container(
                      height: 200,
                      width: size.width,
                      color: Colors.green,
                      child: FlutterLogo(
                        size: 50,
                      )),
                )),
            Positioned(
                bottom: 0,
                child: Container(
                  height: 60,
                  width: size.width,
                  color: Colors.lightGreen,
                )),
            Positioned(
              top: 0,
              left: 0,
              child: RaisedButton(
                onPressed: () {
                  controller.forward();
                },
                child: Text("点击1"),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: RaisedButton(
                onPressed: () {
                  controller.reverse();
                },
                child: Text("点击2"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class TranslateAnimation extends StatefulWidget {
  @override
  _TranslateAnimationState createState() => _TranslateAnimationState();
}

class _TranslateAnimationState extends State<TranslateAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<EdgeInsets> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..addListener(() => setState(() {}));

    animation = EdgeInsetsTween(
      begin: EdgeInsets.only(left: 5.0, top: 20.0),
      end: EdgeInsets.only(left: 80.0, top: 140.0),
    ).animate(animationController);

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Translate Animation")),
      body: Container(
          margin: animation.value,
          child: FlutterLogo(
            size: 50,
          )),
    );
  }
}
