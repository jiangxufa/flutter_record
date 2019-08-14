import 'package:flutter/material.dart';
import 'package:flutter_demo/list_data.dart';

void main() => runApp(MyApp());

/// 每次MaterialApp需要渲染时或者在Flutter Inspector中切换平台时 build 都会运行.
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        indicatorColor: Colors.green,
        primaryColor: Colors.white,
      ),
      home: HomeLayout(),
    );
  }
}
