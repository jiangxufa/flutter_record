import 'package:flutter/material.dart';


class FadeBgContainer extends StatefulWidget{

  final AnimationController controller;

  const FadeBgContainer({Key key, this.controller}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FadeBgContainerState();
  }
}

class FadeBgContainerState extends State<FadeBgContainer>{

  Animation<Matrix4> animation;
  Animation<double> doubleAnimation;

  @override
  void initState() {
    super.initState();
    doubleAnimation = CurvedAnimation(parent: widget.controller, curve: Curves.easeIn);
    animation = new Matrix4Tween(
        begin: Matrix4.translationValues(0, 300, 0),
        end: Matrix4.translationValues(0, 0, 0))
        .animate(widget.controller);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      child: Stack(
        children: <Widget>[
          FadeTransition(
            opacity: widget.controller,
            child: GestureDetector(
              onTap: (){
                widget.controller.reverse();
              },
              child: Container(
                color: Colors.grey,
              ),
            ),
          ),
          Positioned(
              bottom: 56,
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
        ],
      ),
    );
  }
}