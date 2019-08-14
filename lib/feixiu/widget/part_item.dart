import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/feixiu/widget/add_reduce_widget.dart';

class PartItem extends StatefulWidget {
  final Part part ;

  PartItem({this.part});

  @override
  State<StatefulWidget> createState() {
    return PartItemState();
  }
}

class PartItemState extends State<PartItem> with OnAddReduceClickListener {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 4.0, 8.0, 4.0),
      width: double.infinity,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
//      color: Colors.grey,
      constraints: BoxConstraints(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: Container(
//                color: Colors.lightGreen,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[_buildTitleLine(), _buildContentLine()],
                ),
              )),
          AddReduceLayout(widget.part, this)
        ],
      ),
    );
  }

  _buildTitleLayout() {
    return Text(
      "啦啦啦啦啦啦",
      style: TextStyle(fontSize: 16, color: Colors.black38),
    );
  }

  @override
  void onAddClick() {
    print("onAddClick");
    setState(() {
      widget.part.num++;
    });
  }

  @override
  void onCountClick() {}

  @override
  void onReduceClick() {
    print("onReduceClick");
    setState(() {
      if (widget.part.num > 1) {
        widget.part.num--;
      } else {
        widget.part.num = 0;
      }
    });
  }

  @override
  void onRemove() {}

  Widget _buildTitleLine() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          ExtendedText.rich(TextSpan(children: <TextSpan>[
            TextSpan(text: "和黑hi黑黑和黑hi黑黑hi黑黑和黑hi黑黑"),
            TextSpan(text: " "),
            BackgroundTextSpan(
                text: " 标品 ",
                style: TextStyle(color: Colors.white, fontSize: 12),
                background: Paint()..color = Colors.orange,
                clipBorderRadius: BorderRadius.all(Radius.circular(3.0))),
            TextSpan(text: " "),
            BackgroundTextSpan(
                text: " 小修 ",
                style: TextStyle(color: Colors.white, fontSize: 12),
                background: Paint()..color = Colors.grey,
                clipBorderRadius: BorderRadius.all(Radius.circular(3.0))),
          ])),
        ],
      ),
    );
  }

  Widget _buildContentLine() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          ExtendedText.rich(TextSpan(children: <TextSpan>[
            TextSpan(text: ""),
            TextSpan(text: "25元/套 "),
            TextSpan(
                text: "原价：50元",
                style: TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.grey)),
            TextSpan(text: " "),
            BackgroundTextSpan(
                text: "自定义",
                style: TextStyle(color: Colors.white, fontSize: 12),
                background: Paint()..color = Colors.orange,
                clipBorderRadius: BorderRadius.all(Radius.circular(3.0))),
            TextSpan(text: " "),
            BackgroundTextSpan(
                text: "延保30天",
                style: TextStyle(color: Colors.white, fontSize: 12),
                background: Paint()..color = Colors.orange,
                clipBorderRadius: BorderRadius.all(Radius.circular(3.0))),
          ])),
        ],
      ),
    );
  }
}

class Part {
  int num;

  Part(this.num);
}

abstract class OnAddReduceClickListener {
  void onAddClick();

  void onReduceClick();

  void onCountClick();

  void onRemove();
}
