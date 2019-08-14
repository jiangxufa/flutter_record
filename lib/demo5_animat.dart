import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_demo/list_data.dart';

class AnimationLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '关于导航的Demo',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('关于导航的Demo'),
        ),
        body: ListView(children: <Widget>[
          ListData.createTitleLayout(
              "基本动画的使用",
              RaisedButton(
                onPressed: () {
                  ListData.pushPage(context, LogoAnimationLayout());
                },
                child: Text("点击"),
              )),
          ListData.createTitleLayout(
              "使用AnimatedWidget 实现动画(还是拿到animation对象去更新ui) "
                  "AnimatedWidget(基类)中会自动调用addListener()和setState()",
              RaisedButton(
                onPressed: () {
                  ListData.pushPage(context, LogoAnimationLayout1());
                },
                child: Text("点击"),
              )),
          ListData.createTitleLayout(
              "使用AnimatedBuilder 进行职责分离 相当于动画容器 外部传递View进去"
                  "自动监听来自Animation对象的通知，并根据需要将该控件树标记为脏(dirty)，因此不需要手动调用addListener()。",
              RaisedButton(
                onPressed: () {
                  ListData.pushPage(context, LogoAnimationLayout2());
                },
                child: Text("点击"),
              )),
          ListData.createTitleLayout(
              "AnimatedWidget 同时进行缩放和透明变化",
              RaisedButton(
                onPressed: () {
                  ListData.pushPage(context, LogoAnimationLayout3());
                },
                child: Text("点击"),
              )),
          ListData.createTitleLayout(
              "弹簧View",
              RaisedButton(
                onPressed: () {
                  ListData.pushPage(context, PhysicsCardDragDemo());
                },
                child: Text("点击"),
              )),
          ListData.createTitleLayout(
              "使用AnimatedContainer进行设置 宽高边框背景动画",
              RaisedButton(
                onPressed: () {
                  ListData.pushPage(context, AnimatedContainerApp());
                },
                child: Text("点击"),
              )),
          ListData.createTitleLayout(
              "使用AnimatedOpacity进行设置 透明渐变  (给定一个状态 自动动画过度)",
              RaisedButton(
                onPressed: () {
                  ListData.pushPage(context, AnimatedOpacityApp());
                },
                child: Text("点击"),
              )),
        ]),
      ),
    );
  }
}

class LogoAnimationLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LogoAnimationState();
  }
}

class LogoAnimationState extends State<LogoAnimationLayout>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          controller.reverse();
        } else if (state == AnimationStatus.dismissed) {
          controller.forward();
        }
      })
      ..addListener(() {
        setState(() {
          //动画执行的时候 可以看法到疯狂的回调(用来刷新ui)
          print("addListener");
        });
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('基本动画的使用'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          height: animation.value,
          width: animation.value,
          child: FlutterLogo(),
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

///**************************************************************************************

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, @required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}

class LogoAnimationLayout1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LogoAnimation1State();
  }
}

class LogoAnimation1State extends State<LogoAnimationLayout1>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedLogo(
      animation: animation,
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

///**************************************************************************************

class GrowTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  GrowTransition(this.child, this.animation);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: animation.value,
              width: animation.value,
              child: FlutterLogo(),
            );
          }),
    );
  }
}

class LogoAnimationLayout2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LogoAnimation2State();
  }
}

class LogoAnimation2State extends State<LogoAnimationLayout2>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GrowTransition(FlutterLogo(), animation);
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

///**************************************************************************************

class AnimatedLogo1 extends AnimatedWidget {
  static final _opacityTween = new Tween<double>(begin: 0.1, end: 1.0);
  static final _sizeTween = new Tween<double>(begin: 0.0, end: 300.0);

  AnimatedLogo1({Key key, @required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: FlutterLogo(),
        ),
      ),
    );
  }
}

class LogoAnimationLayout3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LogoAnimation3State();
  }
}

class LogoAnimation3State extends State<LogoAnimationLayout3>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedLogo1(
      animation: animation,
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

///**************************************************************************************

class PhysicsCardDragDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("弹簧View"),
      ),
      body: DraggableCard(FlutterLogo(
        size: 128,
      )),
    );
  }
}

class DraggableCard extends StatefulWidget {
  final Widget child;

  DraggableCard(this.child);

  @override
  State<StatefulWidget> createState() {
    return DraggableCardState();
  }
}

class DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Alignment> _animation;
  Alignment _dragAlignment = Alignment.bottomRight;

  @override
  void initState() {
    _controller =
    AnimationController(vsync: this, duration: Duration(seconds: 1))
      ..addListener(() {
        setState(() {
          _dragAlignment = _animation.value;
        });
      });
    _updateAnimation();
    super.initState();
  }

  void _updateAnimation() {
    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.bottomRight,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onPanDown: (DragDownDetails details) {
        _controller.stop();
      },
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          _dragAlignment += Alignment(details.delta.dx / (size.width / 2),
              details.delta.dy / (size.height / 2));
        });
      },
      onPanEnd: (DragEndDetails details) {
        _updateAnimation();
        //Align小部件不使用像素。它使用[-1.0，-1.0]和[1.0,1.0]之间的坐标值，其中[0.0,0.0]表示中心
//        _controller.reset();
//        _controller.forward();
        var pxPerSecond = details.velocity.pixelsPerSecond;
        var unitsPerSecondX = pxPerSecond.dx / size.width;
        var unitsPerSecondY = pxPerSecond.dy / size.height;
        var unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
        var unitVelocity = unitsPerSecond.distance;

        var spring = SpringDescription(
          mass: 30,
          stiffness: 1,
          damping: 1,
        );
        var simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

        _controller.animateWith(simulation);
      },
      child: Align(
        alignment: _dragAlignment,
        child: Card(
          child: widget.child,
        ),
      ),
    );
  }
}

///**************************************************************************************
class AnimatedContainerApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AnimatedContainerAppState();
  }
}

class AnimatedContainerAppState extends State<AnimatedContainerApp> {
  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("使用AnimatedContainer进行设置 宽高边框背景动画"),
        ),
        body: Center(
          child: AnimatedContainer(
            width: _width,
            height: _height,
            decoration:
            BoxDecoration(color: _color, borderRadius: _borderRadius),
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              final random = Random();

              // Generate a random width and height.
              _width = random.nextInt(300).toDouble();
              _height = random.nextInt(300).toDouble();

              // Generate a random color.
              _color = Color.fromRGBO(
                random.nextInt(256),
                random.nextInt(256),
                random.nextInt(256),
                1,
              );

              // Generate a random border radius.
              _borderRadius =
                  BorderRadius.circular(random.nextInt(100).toDouble());
            });
          },
          child: Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}

///**************************************************************************************
class AnimatedOpacityApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AnimatedOpacityAppState();
  }
}

class AnimatedOpacityAppState extends State<AnimatedOpacityApp> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("使用AnimatedOpacity进行设置 透明渐变"),
        ),
        body: Center(
          child: AnimatedOpacity(
            opacity: _visible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: Container(
              width: 200,
              height: 200,
              color: Colors.lightGreen,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _visible = !_visible;
            });
          },
          child: Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}
