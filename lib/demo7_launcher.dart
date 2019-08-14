import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "浮动应用栏",
      home: Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  const url = "https://www.baidu.com/";
                  launch(url);
                },
                child: Text("打开百度"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
