import 'package:flutter/material.dart';
import 'package:flutter_demo/list_data.dart';

///StatefulWidget和State类。
class ResponseLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '关于响应状态管理的Demo',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('关于响应状态管理的Demo'),
        ),
        body: ListView(
          children: <Widget>[
            Counter(),
            Counter2(),
            MaterialButton(
              // ignore: use_of_void_result
              onPressed: ListData.pushPage(context,ShoppingList(
                products: <Product>[
                  Product(name: 'Eggs'),
                  Product(name: 'Flour'),
                  Product(name: 'Chocolate chips'),
                ],
              )),
              child: Text("购物车的例子"),)
          ],
        ),
      ),
    );
  }
}

/// ***************************************widget管理自己的状态****************************************************/
class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListData.createTitleLayout(
        "自己管理",
        Row(
          children: <Widget>[
            RaisedButton(
              onPressed: _increment,
              child: Text('Increment'),
            ),
            Text('Count: $_counter'),
          ],
        ));
  }
}

/// ***************************************widget管理自己的状态****************************************************/

/// ***************************************通过有状态父View控制两个无状态的子View****************************************************///
class CounterDisplay extends StatelessWidget {
  CounterDisplay({this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Text('Count: $count');
  }
}

class CounterIncrementor extends StatelessWidget {
  CounterIncrementor({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: Text('Increment'),
    );
  }
}

class Counter2 extends StatefulWidget {
  @override
  _CounterState2 createState() => _CounterState2();
}

class _CounterState2 extends State<Counter2> {
  int _counter = 0;

  void _increment() {
    setState(() {
      ++_counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListData.createTitleLayout(
        "通过有状态父View控制两个无状态的子View(在setState的时候，由于重走build方法，也会更改子View)",
        Row(children: <Widget>[
          CounterIncrementor(onPressed: _increment),
          CounterDisplay(count: _counter),
        ]));
  }
}

/// ***************************************通过有状态父View控制两个无状态的子View****************************************************/

/// ***************************************购物车的例子****************************************************/
class Product {
  const Product({this.name});

  final String name;
}

typedef void CartChangedCallback(Product product, bool inCar);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({Product product, this.inCart, this.onCartChanged})
      : product = product,
        super(key: ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCartChanged(product, inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(product.name, style: _getTextStyle(context)),
    );
  }
}

///框架将新构建的小部件与先前构建的小部件进行比较，并仅将差异应用于基础 RenderObject。
class ShoppingList extends StatefulWidget {
  ShoppingList({Key key, this.products}) : super(key: key);

  final List<Product> products;

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingCart = Set<Product>();

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      if (!inCart)
        _shoppingCart.add(product);
      else
        _shoppingCart.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((Product product) {
          return ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}


/// ***************************************购物车的例子****************************************************/
