import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';

class UserOptions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new UserOptionsState();
  }
}

class UserOptionsState extends State<UserOptions> {
//save the result of gallery file
  File galleryFile;
  String _uploadedfileurl;

//save the result of camera file
  File cameraFile;
  bool prog=false;
  String msg="";

  @override
  Widget build(BuildContext context) {
    //display image selected from gallery
    imageSelectorGallery() async {
      galleryFile = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        // maxHeight: 50.0,
        // maxWidth: 50.0,
      );

      setState(() {});
    }

    //display image selected from camera
    imageSelectorCamera() async {
      galleryFile = await ImagePicker.pickImage(
        source: ImageSource.camera,
        //maxHeight: 50.0,
        //maxWidth: 50.0,
      );

      setState(() {});
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Image Picker'),
      ),
      body: new Builder(
        builder: (BuildContext context) {
          return new Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new RaisedButton(
                child: new Text('Select Image from Gallery'),
                onPressed: imageSelectorGallery,
              ),
              new RaisedButton(
                child: new Text('Select Image from Camera'),
                onPressed: imageSelectorCamera,
              ),
              displaySelectedFile(galleryFile),
              progressof(),
              new RaisedButton(onPressed: uploadFile,child: Text("UPLOAD"),)

            ],
          );
        },
      )
    );
  }

  void call(){
    uploadFile();
  }

  void _onItemTapped(int index) {
    setState(() {
      uploadFile();
    });
  }
  Widget displaySelectedFile(File file) {
    return new SizedBox(
      height: 200.0,
      width: 300.0,
//child: new Card(child: new Text(''+galleryFile.toString())),
//child: new Image.file(galleryFile),
      child: file == null
          ? new Text('Sorry nothing selected!!')
          : new Image.file(file),
    );
  }

  Future uploadFile() async {
    if(galleryFile==null){
      return;
    }
    setState(() {
      prog =true;
    });
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('analysisimg/'+basename(galleryFile.path));
    StorageUploadTask uploadTask = storageReference.putFile(galleryFile);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedfileurl = fileURL;
        sendtoapi();
      });
    });
  }

  sendtoapi() async{
    Response response;
    Dio dio = new Dio();
    dio.options.baseUrl = "http://34.93.92.101:5000/jsonapp";
    dio.options.connectTimeout = 120000;
    print(_uploadedfileurl);
    try{
      response = await dio.post("http://34.93.92.101:5000/jsonapp", data: {"img":_uploadedfileurl});
      print(response.data);
      galleryFile = null;
    }
    catch(HttpExecption) {
      galleryFile = null;
      setState(() {
        prog =false;
        msg = "error";
      });
      print(HttpExecption.toString());
    }

  }

  Widget progressof(){
    if(prog){
      return new Container(
        height: 50.0,
        child: new Column(
          children: <Widget>[
            new CircularProgressIndicator(),
            new Text("Uploading..!")
          ],
        ),
      );
    }
    else{
     return Container(
        child: Text(msg),
      );
    }
  }
}