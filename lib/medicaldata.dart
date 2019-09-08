import 'package:firebase_database/firebase_database.dart';

class medicaldata {
  String _id;
  String _uid;
  String _var1;
  String _var2;
  String _var3;
  String _var4;
  String _var5;
  String _var6;
  String _var7;
  String _var0;
  String _img;

  medicaldata(this._id, this._uid, this._var1, this._var2, this._var3,
      this._var4, this._var5, this._var6, this._var7, this._var0, this._img);

  String get uid => _uid;

  String get id => _id;

  medicaldata.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _uid = snapshot.value['uid'];
    _var1 = snapshot.value['var1'];
    _var2 = snapshot.value['var2'];
    _var3 = snapshot.value['var3'];
    _var4 = snapshot.value['var4'];
    _var5 = snapshot.value['var5'];
    _var6 = snapshot.value['var6'];
    _var7 = snapshot.value['var7'];
    _var0 = snapshot.value['var0'];
    _img = snapshot.value['img'];
  }

  String get var1 => _var1;

  String get var2 => _var2;

  String get var3 => _var3;

  String get var4 => _var4;

  String get var5 => _var5;

  String get var6 => _var6;

  String get var7 => _var7;

  String get var0 => _var0;

  String get img => _img;
}
