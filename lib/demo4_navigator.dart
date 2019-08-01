import 'package:flutter/material.dart';
import 'package:flutter_demo/list_data.dart';

class NavigatorLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '关于导航的Demo',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('关于导航的Demo'),
        ),
        body: ListView(children: <Widget>[
          ListData.createTitleLayout(
              "使用hero动画进行过度(相当于android里面的过渡动画) 使用hero控件和设置tag就行",
              RaisedButton(
                onPressed: () {
                  ListData.pushPage(context, MainScreen());
                },
                child: Text("点击"),
              )),
          ListData.createTitleLayout(
              "使用push/pop进行跳转",
              RaisedButton(
                onPressed: () {
                  ListData.pushPage(context, FirstRoute());
                },
                child: Text("点击"),
              )),
          ListData.createTitleLayout(
              "使用路径名称`pushNamed`进行跳转(使用时initialRoute，请勿定义home属性)",
              RaisedButton(
                onPressed: () {
                  ListData.pushPage(context, RouterByNameLayout());
                },
                child: Text("点击"),
              )),
          ListData.createTitleLayout(
              "传递数据到指定路径",
              RaisedButton(
                onPressed: () {
                  ListData.pushPage(context, RouterWithArgLayout());
                },
                child: Text("点击"),
              )),
          ListData.createTitleLayout(
              "接受屏幕返回数据  Navigation会返回一个Future对象,这里面直接使用 async await去等待返回结果",
              RaisedButton(
                onPressed: () {
                  ListData.pushPage(context, ReceiveArgLayout());
                },
                child: Text("点击"),
              )),
        ]),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return DetailScreen();
          }));
        },
        child: Hero(
          tag: 'imageHero',
          child: Image.network(
            'https://picsum.photos/250?image=9',
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              'https://picsum.photos/250?image=9',
            ),
          ),
        ),
      ),
    );
  }
}

///*******************************************************************************

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Open route'),
          onPressed: () {
            // Navigate to second route when tapped.
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondRoute()),
            );
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

///*******************************************************************************
/// 使用时initialRoute，请勿定义home属性
class RouterByNameLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => FirstScreen1(),
        "/second": (context) => SecondScreen2(),
      },
    );
  }
}

class FirstScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Launch screen'),
          onPressed: () {
            // Navigate to the second screen when tapped.
            Navigator.pushNamed(context, "/second");
          },
        ),
      ),
    );
  }
}

class SecondScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first screen when tapped.
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

///*******************************************************************************
//申明传递的参数
class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}

class RouterWithArgLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //相当于回调  通过路径去手动构造对象
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == PassArgumentsScreen.routeName) {
          ScreenArguments arguments = settings.arguments;
          return MaterialPageRoute(builder: (context) {
            return PassArgumentsScreen(
                title: arguments.title, message: arguments.message);
          });
        }
      },
      title: '传递数据到指定路径',
      home: HomeScreen(),
    );
  }
}

class ExtractArgumentsScreen extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute settings and cast
    // them as ScreenArguments.
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Text(args.message),
      ),
    );
  }
}

// A Widget that accepts the necessary arguments via the constructor.
class PassArgumentsScreen extends StatelessWidget {
  static const routeName = '/passArguments';

  final String title;
  final String message;

  // This Widget accepts the arguments as constructor parameters. It does not
  // extract the arguments from the ModalRoute.
  //
  // The arguments are extracted by the onGenerateRoute function provided to the
  // MaterialApp widget.
  const PassArgumentsScreen({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // A button that navigates to a named route that. The named route
            // extracts the arguments by itself.
            RaisedButton(
              child: Text("导航到提取参数的屏幕"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExtractArgumentsScreen(),
                    settings: RouteSettings(
                      arguments: ScreenArguments(
                        '传递参数1',
                        '嘿嘿嘿嘿嘿嘿',
                      ),
                    ),
                  ),
                );
              },
            ),
            RaisedButton(
              child: Text("在函数内部提取参数onGenerateRoute() 并将它们传递给窗口小部件"),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  PassArgumentsScreen.routeName,
                  arguments: ScreenArguments(
                    '传递参数2',
                    '哈哈哈哈',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

///*******************************************************************************
class ReceiveArgLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('接受屏幕返回数据'),
      ),
      body: Center(child: SelectionButton()),
    );
  }
}

class SelectionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        _navigateAndDisplaySelection(context);
      },
      child: Text('选择一个选项'),
    );
  }

  ///启动SelectionScreen并等待结果的返回
  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectionScreen()),
    );

    //选择屏幕返回结果后，隐藏以前的snackbar
    //并显示新的结果。
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }
}

class SelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('选择'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context, '是的!');
                },
                child: Text('是的!'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context, '不.');
                },
                child: Text('不.'),
              ),
            )
          ],
        ),
      ),
    );
  }
}