import 'package:flutter/material.dart';

class DrawerLayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "drawer的使用",
      home: HomeDrawerPage(),
    );
  }
}

class HomeDrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("drawer的使用"),
      ),
      body: Center(child: Text('My Page!')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Image.asset(
                "images/lake.jpg",
                height: 240.0,
                fit: BoxFit.cover,
              ),
              padding: EdgeInsets.zero,
            ),
            ListTile(
              title: Text("item1"),
              onTap: () {
                ///必须要使用自己widget的context (直接写在DrawerLayoutDemo的home里面会直接退出界面)
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("item2"),
            ),
            ListTile(
              title: Text("item3"),
            ),
            ListTile(
              title: Text("item4"),
            ),
            ListTile(
              title: Text("item5"),
            ),
            ListTile(
              title: Text("item6"),
            ),
            ListTile(
              title: Text("item7"),
            ),
            ListTile(
              title: Text("item8"),
            ),
            ListTile(
              title: Text("item9"),
            ),
            ListTile(
              title: Text("item10"),
            ),
            ListTile(
              title: Text("item11"),
            ),
            ListTile(
              title: Text("item12"),
            ),
            ListTile(
              title: Text("item13"),
            ),
            ListTile(
              title: Text("item14"),
            ),
            ListTile(
              title: Text("item15"),
            ),
            ListTile(
              title: Text("item16"),
            ),
          ],
        ),
      ),
    );
  }
}
