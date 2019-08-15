import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_demo/feixiu/animat/berzier/bezier_container.dart';
import 'package:flutter_demo/feixiu/bottom_car_layout.dart';
import 'package:flutter_demo/feixiu/part_fragment.dart';
import 'package:flutter_demo/feixiu/widget/part_bottom_sheet.dart';
import 'package:flutter_demo/feixiu/widget/part_item.dart';

class AddPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddPageState();
  }
}

class AddPageState extends State<AddPage> with AddReduceClickListener,BezierAnimationContainerCallBack{
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool isOpen = false;
  PersistentBottomSheetController showBottomSheet;
  Queue<Widget> animatWidgets = Queue();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("添加零件"),),
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 54),
            child: PageFragment(_scaffoldKey,(){
              showSpuSheet(context);
            },listener: this,),
          ),
          BottomCarLayout()
        ]..addAll(animatWidgets.toList()),
      ),
    );
  }

  showSpuSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SpuBottomSheetLayout();
        });
  }

  @override
  void onAddClick() {
  }

  @override
  void onAddPosition(Offset offset) {
    print("offset    ${offset.dx}     ${offset.dy}");
    animatWidgets.addFirst(BezierAnimationContainer(this,
        FlutterLogo(size: 50,),
        Matrix4.translationValues(offset.dx+22, offset.dy, 0),
        Matrix4.translationValues(20, 500, 0)));
    setState(() {
    });
  }

  @override
  void onCountClick() {
  }

  @override
  void onReduceClick() {
  }

  @override
  void onRemove() {
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
