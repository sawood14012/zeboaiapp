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
  bool prog = false;
  String msg = "";

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

    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  displaySelectedFile(galleryFile),
                  progressof(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: ButtonTheme(
                            child: RaisedButton(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  'Select Image from Gallery',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              onPressed: imageSelectorGallery,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: ButtonTheme(
                            child: RaisedButton(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  'Select Image from Camera',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              onPressed: imageSelectorCamera,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Material(
            color: Theme.of(context).primaryColor,
            child: InkWell(
              onTap: () {},
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Upload',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void call() {
    uploadFile();
  }

  void _onItemTapped(int index) {
    setState(() {
      uploadFile();
    });
  }

  Widget displaySelectedFile(File file) {
    return Center(
      child: new SizedBox(
        height: 200.0,
        width: 300.0,
//child: new Card(child: new Text(''+galleryFile.toString())),
//child: new Image.file(galleryFile),
        child: Center(
          child: file == null
              ? new Text('Sorry nothing selected!!')
              : new Image.file(file),
        ),
      ),
    );
  }

  Future uploadFile() async {
    if (galleryFile == null) {
      return;
    }
    setState(() {
      prog = true;
    });
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('analysisimg/' + basename(galleryFile.path));
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

  sendtoapi() async {
    print(_uploadedfileurl);
    try {
      Response response = await Dio().post(
        "http://34.93.92.101:5000/jsonapp",
        options: Options(
          connectTimeout: 120000,
        ),
        data: {
          "img": _uploadedfileurl,
        },
      );
      print(response.data);
    } on HttpException catch (error) {
      galleryFile = null;
      setState(
        () {
          prog = false;
          msg = "error";
        },
      );
      print(error);
    }
  }

  Widget progressof() {
    if (prog) {
      return new Container(
        height: 50.0,
        child: new Column(
          children: <Widget>[
            new CircularProgressIndicator(),
            new Text("Uploading..!")
          ],
        ),
      );
    } else {
      return Container(
        child: Text(msg),
      );
    }
  }
}
