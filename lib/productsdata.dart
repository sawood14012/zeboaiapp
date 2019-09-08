import 'package:firebase_database/firebase_database.dart';

class productsdata {
  String _id;
  String _title;
  String _image;
  String _price;
  String _description;
  String _shortdesc;

  productsdata(this._id, this._title, this._image, this._price,
      this._description, this._shortdesc);

  String get description => _description;

  String get price => _price;

  String get image => _image;

  String get title => _title;

  String get id => _id;

  String get shortdesc => _shortdesc;

  productsdata.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _title = snapshot.value['title'];
    _image = snapshot.value['image'];
    _price = snapshot.value['price'];
    _description = snapshot.value['description'];
    _shortdesc = snapshot.value['shortdesc'];
  }
}
