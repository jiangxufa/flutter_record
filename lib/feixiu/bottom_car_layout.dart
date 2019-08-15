import 'package:flutter/material.dart';
import 'package:flutter_demo/feixiu/animat/fade_bg_transform_content_layout.dart';

class BottomCarLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BottomCarLayoutState();
  }
}

class BottomCarLayoutState extends State<StatefulWidget>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  bool isOpen = false;
  bool isAnimatStart = false;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this)
      ..addListener(() {
        setState(() {
          //动画执行的时候 可以看法到疯狂的回调(用来刷新ui)
        });
      })
      ..addStatusListener((state) {
        switch (state) {
          case AnimationStatus.dismissed:
            isOpen = false;
            isAnimatStart = false;
            break;
          case AnimationStatus.forward:
            isAnimatStart = true;
            break;
          case AnimationStatus.reverse:
            isAnimatStart = true;
            break;
          case AnimationStatus.completed:
            isOpen = true;
            break;
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        isAnimatStart?FadeBgContainer(
          controller: controller,
        ):Container(),
        _buildBottomBox(),
      ],
    );
  }

  _buildBottomBox() => Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: GestureDetector(
          onTap: () {
            if (!isOpen) {
              controller.forward();
            } else {
              controller.reverse();
            }
            setState(() {});
          },
          child: Container(
            color: Colors.white,
            height: 56,
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: <Widget>[
                  _buildOver(),
                  _buildBottomBoxPriceLayout(),
                  RaisedButton(
                    color: Colors.lightGreen,
                    onPressed: () {},
                    child: Text(
                      "下一步",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  _buildBottomBoxPriceLayout() => Expanded(
          child: Padding(
        padding: EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "维修点费:0元",
              style: TextStyle(color: Colors.lightGreen, fontSize: 16),
            ),
            Text(
              "共计:0元",
              style: TextStyle(color: Colors.black38, fontSize: 12),
            )
          ],
        ),
      ));

  _buildOver() => GestureDetector(
        onTap: () {
          if (!isOpen) {
            controller.forward();
          } else {
            controller.reverse();
          }
          setState(() {});
        },
        child: Container(
            width: 56,
            height: 56,
            padding: EdgeInsets.only(left: 16, bottom: 16, right: 16),
            child: OverflowBox(
              alignment: Alignment.bottomCenter,
              maxHeight: 100,
              maxWidth: 100,
              child: Image.asset(
                "images/new_icon_box_close.png",
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            )),
      );
}
