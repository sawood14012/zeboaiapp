# zeboai

A  Flutter application for zebo.ai.

## Getting Started:

the bundel identifier and the package name for generating firebase config is
#### ai.zebo.zebo

## setup :

Generate SHA1 for your app : follow this [generate sha1](https://stackoverflow.com/questions/27609442/how-to-get-the-sha-1-fingerprint-certificate-in-android-studio-for-debug-mode#34223470)
* note you need to add SHA1 to your firebase app inorder to use Google signin
* to enable google signin for ios follow this click [here](https://firebase.google.com/docs/auth/ios/firebaseui#google)



To know how to add firebase config [How to add firebase to flutter app](https://firebase.google.com/docs/flutter/setup)
use ai.zebo.zebo as package name and bundle identifier



* add the GoogleService-Info.plist in ios/Runner/ directory
* add the google-services.json in android/app directory

## change the api url:

1. go to lib/upload.dart
2. change the url in the function sendtoapi()

```Dart
void sendtoapi(BuildContext context) async {
    print(_uploadedfileurl);
    try {
      Response response = await Dio().post(
        "NEW-URL-HERE", 
        options: Options(
          connectTimeout: 100000,
        ),
        data: {
          "img": _uploadedfileurl,
        },
      );
    } on HttpException catch (error) {
      
    }
  }
```

## Building :
To build apk:
* run `flutter build apk`









