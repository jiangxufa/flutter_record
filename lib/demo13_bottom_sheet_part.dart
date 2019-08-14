import 'package:flutter/material.dart';
import 'package:flutter_demo/feixiu/widget/part_bottom_sheet.dart';

class PartBottomSheetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RaisedButton(
        onPressed: () {
          showBottomSheet(context);
        },
        child: Text("嘿嘿嘿"),
      ),
    );
  }

  showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SpuBottomSheetLayout();
        });
  }
}
