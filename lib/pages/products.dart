import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:zebo/productsdata.dart';
import 'package:zebo/firebase_db_util.dart';

class Products extends StatefulWidget {
  Products({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  bool _anchorToBottom = false;
  FirebaseDatabaseUtil databaseUtil;

  // ignore: non_constant_identifier_names

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseUtil = new FirebaseDatabaseUtil();
    databaseUtil.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  bool _cartopen = false;
  bool _loading = false;
  bool _cartswitch = false;
  Icon _searchIcon = new Icon(Icons.search);
  Icon _carticon = new Icon(Icons.shopping_cart);
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  Widget _appBarTitle = new Text('Products');
  FirebaseDatabase database = new FirebaseDatabase();
  Widget _appbody;

  _ProductsState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          //filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    _appbody = normaldata();

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: this._appBarTitle,
      ),
      body: _buildList(),
    );
  }

  Future<String> _refresh() async {
    await new Future.delayed(new Duration(seconds: 3), () {
      print("refreshing");
    }).then(print).catchError(print).whenComplete(() {
      print('done!');
      return "s";
    });
  }

  normaldata() {
    return new RefreshIndicator(
      child: new FirebaseAnimatedList(
          query: databaseUtil.getUser(),
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            return new SizeTransition(
              sizeFactor: animation,
              child: showUser(snapshot),
            );
          }),
      onRefresh: _refresh,
      displacement: 20.0,
      backgroundColor: Colors.black,
    );
  }

  cartdata() {
    return new Container();
  }

  _buildList() {
    //print(_loading);

    return normaldata();
  }

  Widget showUser(DataSnapshot res) {
    productsdata pdata = productsdata.fromSnapshot(res);

    var item = new Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Image.network(
              pdata.image,
              height: 100.0,
              width: 100.0,
            ),
            title: Text(pdata.title),
            subtitle: Text("Rs " + pdata.price),
            onTap: () {},
          ),
          ButtonTheme.bar(
            // make buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('BUY NOW'),
                  onPressed: () {
                    /* ... */
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return item;
  }
}
