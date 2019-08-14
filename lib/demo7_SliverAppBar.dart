import 'package:flutter/material.dart';

class SliverAppBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "浮动应用栏",
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text("浮动应用栏"),
              floating: true,
              flexibleSpace: Placeholder(),
              centerTitle: true,
              expandedHeight: 200,
              pinned: true,
              snap: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) => ListTile(title: Text('Item #$index')),
                childCount: 1000,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

