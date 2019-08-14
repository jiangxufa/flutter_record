import 'package:flutter/material.dart';

class PageDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _PageDemoState();
}

class _PageDemoState extends State<PageDemo> {
  final PageController _pageController = new PageController();
  double _currentPage = 0.0;

  @override
  Widget build(BuildContext context) => new Scaffold(
        appBar: new AppBar(
          title: const Text('Page Demo'),
        ),
        body: new LayoutBuilder(
            builder: (context, constraints) => new NotificationListener(
                  onNotification: (ScrollNotification note) {
                    setState(() {
                      _currentPage = _pageController.page;
                    });
                  },
                  child: new PageView.custom(
                    physics: const PageScrollPhysics(
                        parent: const BouncingScrollPhysics()),
                    controller: _pageController,
                    childrenDelegate: new SliverChildBuilderDelegate(
                      (context, index) => new _SimplePage(
                        '$index\n'
                        '_currentPage=$_currentPage\n'
                        'maxWidth=${constraints.maxWidth}\n'
                        '${constraints.maxWidth / 2.0 * (index - _currentPage)}',
                        parallaxOffset:
                            constraints.maxWidth / 2.0 * (index - _currentPage),
                      ),
                      childCount: 10,
                    ),
                  ),
                )),
      );
}

class _SimplePage extends StatelessWidget {
  _SimplePage(this.data, {Key key, this.parallaxOffset = 0.0})
      : super(key: key);

  final String data;
  final double parallaxOffset;

  @override
  Widget build(BuildContext context) => new Center(
        child: new Center(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Text(
                data,
                style: const TextStyle(fontSize: 16.0),
              ),
              new SizedBox(height: 40.0),
              new Transform(
                transform:
                    new Matrix4.translationValues(parallaxOffset, 0.0, 0.0),
                child: const Text('Yet another line of text'),
              ),
            ],
          ),
        ),
      );
}
