import 'package:flutter/material.dart';

class BottomSheetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BottomSheetPageState();
  }
}

class BottomSheetPageState extends State<BottomSheetPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  VoidCallback _showBottomSheetCallback;

  @override
  void initState() {
    super.initState();
    _showBottomSheetCallback = _showBottomSheet;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: RaisedButton(
          onPressed: _showBottomSheetCallback,
          child: Text("点击"),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    setState(() {
      // disable the button
      _showBottomSheetCallback = null;
    });
    _scaffoldKey.currentState
        .showBottomSheet((BuildContext context) {
          return Container(
            height: 400,
            color: Colors.blue,
          );
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              // re-enable the button
              _showBottomSheetCallback = _showBottomSheet;
            });
          }
        });
  }
}
