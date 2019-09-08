import 'package:flutter/material.dart';

import 'package:zebo/services/authentication.dart';
import 'package:zebo/pages/root_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zebo/pages/CardItemModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zebo/pages/form_page.dart';
import 'package:zebo/pages/medicalhistory.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.userId, this.auth, this.onSignedOut})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final String userId;
  final void onSignedOut;
  final BaseAuth auth;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  bool _anchorToBottom = false;

  var appColors = [
    Color.fromRGBO(231, 129, 109, 1.0),
    Color.fromRGBO(99, 138, 223, 1.0),
    Color.fromRGBO(111, 194, 173, 1.0)
  ];
  var cardIndex = 0;
  ScrollController scrollController;
  var currentColor = Color.fromRGBO(231, 129, 109, 1.0);
  String name = "";
  var cardsList = [
    CardItemModel("Acne Analysis", Icons.account_circle, 9, 1.0),
    CardItemModel("Chat bot", Icons.work, 12, 1.0),
    CardItemModel("Medical records", Icons.home, 7, 1.0)
  ];

  AnimationController animationController;
  ColorTween colorTween;
  CurvedAnimation curvedAnimation;

  // ignore: non_constant_identifier_names

  @override
  void initState() {
    // TODO: implement initState
    FirebaseAuth.instance.onAuthStateChanged.listen((firebaseUser) {
      // do whatever you want based on the firebaseUser state
      print(firebaseUser.uid);
    });
    super.initState();
    scrollController = new ScrollController();
    DocumentReference myref =
        Firestore.instance.collection("users").document(widget.userId);
    myref.get().then((Doc) {
      setState(() {
        name = Doc.data['Name'];
      });
    });
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
  Widget _appBarTitle = new Text('Zebo.ai');

  Widget _appbody;

  @override
  Widget build(BuildContext context) {
    //  _appbody = normaldata();

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: currentColor,
      appBar: AppBar(
        centerTitle: true,
        title: this._appBarTitle,
        backgroundColor: currentColor,
        elevation: 0.0,
        actions: <Widget>[
          /*
          IconButton(
            icon: this._searchIcon,
            tooltip: 'Search',
            onPressed: () {
              this._searchPressed();
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => SecondRoute()));


            },


          ),

          IconButton(
            icon: _carticon,
            tooltip: 'Cart',
            onPressed: () {
              this._cartPressed();
            },

          ),*/
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Zebo.ai'),
              decoration: BoxDecoration(
                color: currentColor,
              ),
            ),
            ListTile(
              title: Text('Acne analysis'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FormPage(id: widget.userId)));
              },
            ),
            ListTile(
              title: Text('Medical History'),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Medicalhistory(id: widget.userId)));
              },
            ),
            ListTile(
              title: Text("Logout"),
              onTap: () {
                widget.auth.signOut();
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RootPage(auth: widget.auth)));
              },
            ),
          ],
        ),
      ),
      body: new Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 64.0, vertical: 32.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Icon(
                        Icons.local_hospital,
                        size: 45.0,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 12.0),
                      child: Text(
                        "Hi," + name + " !",
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Text(
                      "Hope you\'r feeling good",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 350.0,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,



                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, position) {

                      return GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Container(
                              width: 250.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Icon(
                                          cardsList[position].icon,
                                          color: appColors[position],
                                        ),
                                        Icon(
                                          Icons.more_vert,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 4.0),
                                          child: Text(
                                            "${cardsList[position].cardTitle}",
                                            style: TextStyle(fontSize: 28.0),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: LinearProgressIndicator(
                                            value: cardsList[position]
                                                .taskCompletion,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                        ),
                        onHorizontalDragEnd: (details) {
                          animationController = AnimationController(
                              vsync: this,
                              duration: Duration(milliseconds: 500));
                          curvedAnimation = CurvedAnimation(
                              parent: animationController,
                              curve: Curves.fastOutSlowIn);
                          animationController.addListener(
                            () {
                              setState(() {
                                currentColor =
                                    colorTween.evaluate(curvedAnimation);
                              });
                            },
                          );

                          if (details.velocity.pixelsPerSecond.dx > 0) {
                            if (cardIndex > 0) {
                              cardIndex--;
                              colorTween = ColorTween(
                                begin: currentColor,
                                end: appColors[cardIndex],
                              );
                            }
                          } else {
                            if (cardIndex < 2) {
                              cardIndex++;
                              colorTween = ColorTween(
                                  begin: currentColor,
                                  end: appColors[cardIndex]);
                            }
                          }
                          setState(() {
                            scrollController.animateTo((cardIndex) * 256.0,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.fastOutSlowIn);
                          });

                          colorTween.animate(curvedAnimation);

                          animationController.forward();
                        },
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
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
/*
  normaldata(){
    return new RefreshIndicator(child: new FirebaseAnimatedList(query: databaseUtil.getUser(),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          return new SizeTransition(
            sizeFactor: animation,
            child: showUser(snapshot),
          );
        }

    )
      , onRefresh: _refresh,
      displacement: 20.0,
      backgroundColor: Colors.black,
    );
  }

  cartdata(){
    return new Container();
  }




  _buildList() {
    //print(_loading);
    print(_cartopen);
    if(_loading==true){
      String temptxt = _searchText;
      // print(temptxt);
      while(_searchText.isNotEmpty){
        //print(_searchText);
        Query searchquery = database.reference().child('blog').orderByChild('title').startAt(_searchText).endAt(_searchText+ "\uf8ff");
        return new FirebaseAnimatedList(query: searchquery,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              // print(snapshot.value);
              return new SizeTransition(
                sizeFactor: animation,
                child: showUser(snapshot),
              );
            }

        );

      }

    }

    if(_loading == false && _cartswitch == false && _searchText.isEmpty){

      return normaldata();



    }

    if(_cartopen == true && _cartswitch == true){
      print("opencart");
      return cartdata();
    }







  }




  Widget showUser(DataSnapshot res) {
    productsdata pdata = productsdata.fromSnapshot(res);

    var item = new Card(


      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Image.network(pdata.image,height: 100.0,width: 100.0,),
            title: Text(pdata.title),
            subtitle: Text("Rs "+pdata.price),

            onTap: (){
              Firebase_product_key fkey = new Firebase_product_key(pdata.id,pdata.title,pdata.image,pdata.price,pdata.description,pdata.shortdesc);
              Navigator.push(context, MaterialPageRoute(builder: (context) => Singleproduct(fkey: fkey,)));
            },


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
                FlatButton(
                  child: const Text('ADD'),
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

}*/

}
