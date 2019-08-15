import 'package:flutter/material.dart';
import 'package:flutter_demo/feixiu/part_fragment.dart';

class PartCarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PartCarPageState();
  }
}

class PartCarPageState extends State<PartCarPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  VoidCallback _showBottomSheetCallback;
  bool isOpen = false;
  PersistentBottomSheetController showBottomSheet;

  @override
  void initState() {
    super.initState();
    _showBottomSheetCallback = _showBottomSheet;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 64),
            child: PageFragment(_scaffoldKey,(){}),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                height: 64,
                width: size.width,
                color: Colors.greenAccent,
                child: RaisedButton(
                  onPressed: _showBottomSheetCallback,
                  child: Text("点击"),
                ),
              ))
        ],
      ),
    );
  }

  void _showBottomSheet() {
    setState(() {
      // disable the button
//      _showBottomSheetCallback = null;
    });
    if (isOpen) {
      isOpen = false;
      showBottomSheet.close();
    } else {
      isOpen = true;
      showBottomSheet =
          _scaffoldKey.currentState.showBottomSheet((BuildContext context) {
        return Container(
          height: 400,
          color: Colors.red,
        );
      })/*..closed.whenComplete(() {
              if (mounted) {
                setState(() {
                  // re-enable the button
                  _showBottomSheetCallback = _showBottomSheet;
                });
              }
            })*/;
    }
  }
}
