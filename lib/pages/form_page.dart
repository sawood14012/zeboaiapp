import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:zebo/pages/upload.dart";

class FormPage extends StatefulWidget {
  FormPage({this.id});

   String id;

  @override
  _FormPageState createState() => _FormPageState();


}

class _FormPageState extends State<FormPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String name;
  String genderValue = 'Male';
  String presentSinceBirth = 'No';
  int age;
  bool itchingValue = false;
  bool photosensitivityValue = false;
  bool menstrualValue = false;
  bool feverValue = false;
  bool jointValue = false;
  bool darkingValue = false;
  bool blisteringValue = false;
  bool oralValue = false;
  bool diseaseValue = false;
  bool faceValue = false;
  bool chestValue = false;
  bool backValue = false;
  bool otherValue = false;
  bool noneValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Acne Analysis'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      getTextField(
                        label: 'Name',
                        validator: validateName,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      getGenderWidget,
                      SizedBox(
                        height: 25,
                      ),
                      getTextField(
                        label: 'Age',
                        keyboardType: TextInputType.number,
                        validator: validateAge,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      getPresentSinceBirth,
                      SizedBox(
                        height: 25,
                      ),
                      getMultiCheckBox,
                      SizedBox(
                        height: 25,
                      ),
                      getMultiCheckBox2,
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Material(
            color: Theme.of(context).primaryColor,
            child: InkWell(
              onTap: () {
                pushToDb(context);
              },
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Proceed to upload image',
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

  Widget get getGenderWidget {
    return Container(
      child: Column(
        children: <Widget>[
          Text('Gender'),
          Row(
            children: <Widget>[
              Expanded(
                child: RadioListTile<String>(
                  title: Text('Male'),
                  value: 'Male',
                  groupValue: genderValue,
                  onChanged: (value) {
                    setState(
                          () {
                        genderValue = value;
                      },
                    );
                  },
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: Text('Female'),
                  value: 'Female',
                  groupValue: genderValue,
                  onChanged: (value) {
                    setState(
                          () {
                        genderValue = value;
                      },
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget get getPresentSinceBirth {
    return Container(
      child: Column(
        children: <Widget>[
          Text('Is it present since Birth?'),
          Row(
            children: <Widget>[
              Expanded(
                child: RadioListTile<String>(
                  title: Text('Yes'),
                  value: 'Yes',
                  groupValue: presentSinceBirth,
                  onChanged: (value) {
                    setState(
                          () {
                        presentSinceBirth = value;
                      },
                    );
                  },
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: Text('No'),
                  value: 'No',
                  groupValue: presentSinceBirth,
                  onChanged: (value) {
                    setState(
                          () {
                        presentSinceBirth = value;
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget get getMultiCheckBox {
    return Column(
      children: <Widget>[
        Text(
          'Choose what all you have?',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              getCheckbox('Itching', itchingValue),
              getCheckbox('Photosensitivity', photosensitivityValue),
              getCheckbox('Menstrual Irregularities', menstrualValue),
              getCheckbox('Fever', feverValue),
              getCheckbox('Joint Pains', jointValue),
              getCheckbox('Darking of folds like chest Neck', darkingValue),
              getCheckbox('Blistering', blisteringValue),
              getCheckbox('Oral Ulcers', oralValue),
              getCheckbox(
                  'Are you on medication for any disease', diseaseValue),
              getCheckbox('None', noneValue),
            ],
          ),
        ),
      ],
    );
  }

  Widget get getMultiCheckBox2 {
    return Column(
      children: <Widget>[
        Text(
          'Which part is affected?',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              getCheckbox('Face', faceValue),
              getCheckbox('Chest', chestValue),
              getCheckbox('Back', backValue),
              getCheckbox('Other', otherValue),
            ],
          ),
        ),
      ],
    );
  }

  Widget getCheckbox(String title, bool boolValue) {
    return Row(
      children: <Widget>[
        Checkbox(
          value: boolValue,
          onChanged: (bool value) {
            setState(
                  () {
                switch (title) {
                  case 'Itching':
                    itchingValue = value;
                    break;
                  case 'Photosensitivity':
                    photosensitivityValue = value;
                    break;
                  case 'Menstrual Irregularities':
                    menstrualValue = value;
                    break;
                  case 'Fever':
                    feverValue = value;
                    break;
                  case 'Joint Pains':
                    jointValue = value;
                    break;
                  case 'Darking of folds like chest Neck':
                    darkingValue = value;
                    break;
                  case 'Blistering':
                    blisteringValue = value;
                    break;
                  case 'Oral Ulcers':
                    oralValue = value;
                    break;
                  case 'Are you on medication for any disease':
                    diseaseValue = value;
                    break;
                  case 'Face':
                    faceValue = value;
                    break;
                  case 'Chest':
                    chestValue = value;
                    break;
                  case 'Back':
                    backValue = value;
                    break;
                  case 'Other':
                    otherValue = value;
                    break;
                  case 'None':
                    noneValue = value;
                    break;
                }
              },
            );
          },
        ),
        Text(title),
      ],
    );
  }

  Widget getTextField({
    @required String label,
    TextEditingController controller,
    TextCapitalization capitalization = TextCapitalization.sentences,
    TextInputType keyboardType = TextInputType.text,
    String Function(String value) validator,
    bool enabled = true,
    int lines,
  }) {
    return Container(
      alignment: Alignment.centerLeft,
      child: TextFormField(
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          letterSpacing: .3,
        ),
        controller: controller,
        enabled: enabled,
        textCapitalization: capitalization,
        keyboardType: keyboardType,
        maxLines: lines,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 4,
          ),
          labelText: label,
          isDense: true,
          labelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        validator: validator,
      ),
    );
  }

  String validateName(
      String value,
      ) {
    if (value.isEmpty) {
      return 'Enter Name';
    }
    name = value;
    return null;
  }

  String validateAge(
      String value,
      ) {
    if (value.isEmpty) {
      return 'Enter Age';
    }
    age = int.parse(value);
    return null;
  }

  Future pushToDb(BuildContext context) async {
    FormState state = formKey.currentState;
    if (state == null) {
      return;
    }
    if (!state.validate()) {
      return;
    }
    if (!itchingValue && !photosensitivityValue && !menstrualValue && !menstrualValue && !feverValue && !jointValue && !darkingValue && !blisteringValue && !oralValue && !diseaseValue && !noneValue) {
      showInSnackBar(context, 'Form cannot be empty');
      return;
    }
    if (!faceValue && !chestValue && !backValue && !otherValue) {
      showInSnackBar(context, 'Form cannot be empty');
      return;
    }
    if (presentSinceBirth == 'Yes') {
      showInSnackBar(context, 'It is unlikely to be acne if it is present since birth');
      return;
    }
    if (age < 10) {
      showInSnackBar(context, 'it is unlikely to be acne if patient\'s age is below 10 years');
      return;
    }
    if (itchingValue || photosensitivityValue || menstrualValue || menstrualValue || feverValue || jointValue || darkingValue || blisteringValue || oralValue || diseaseValue) {
      showInSnackBar(context, 'This seems severe, its advised to see a dermatologist!');
      return;
    }
    if (otherValue) {
      showInSnackBar(context, 'Unlikely to be acne');
      return;
    }
    if(noneValue&&faceValue||chestValue||backValue){
      state.save();
      showInSnackBar(context, 'Loading..!');
      adduserdata();
      Navigator.push(context, new MaterialPageRoute(builder: (context)=> UserOptions(id: widget.id,)));

    }


    // TODO Push to db and check validate functions
  }

  void adduserdata() async {
    await Firestore.instance.collection("acneanalysis").document()
        .setData({
      "uid":widget.id,
      "Name":name,
      "Age":age,
      "gender":genderValue,
      "PSB":presentSinceBirth,
      "Noneselected":noneValue,
      "face":faceValue,
      "chest":chestValue,
      "back":backValue,


    });


  }

  void showInSnackBar(BuildContext context, String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        content:new Container(
          height: 30.0,
          child: Text(message, style: TextStyle(fontSize: 20.0),),
        ),
      ),
    );
  }
}