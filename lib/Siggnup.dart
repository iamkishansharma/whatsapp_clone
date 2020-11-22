import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import 'Constants.dart' as cons;
import 'Login.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.red,
        body: MySignUp(),
      ),
    );
  }
}

class MySignUp extends StatefulWidget {
  @override
  _MySignUpState createState() => _MySignUpState();
}

class _MySignUpState extends State<MySignUp> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();

  File _image;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile =
    await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  uploadPic()async{
    File pikedImage;
    if(_image!=null){
      pikedImage= _image;
    }
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser user = await auth.currentUser();
    StorageReference storageReference = FirebaseStorage.instance.ref().child(user.email).child("profilePic.jpg");
    StorageUploadTask uploadTask = storageReference.putFile(pikedImage);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    print("Profile pic uploaded!");
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            children: <Widget>[
              _getHeader(),
              // _getImage(context),

              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () async{
                    print("Image");
                    getImage();
                  },
                  child: CircleAvatar(
                    backgroundColor: cons.mainColor,
                    radius: MediaQuery.of(context).size.width / 4,
                    child: ClipOval(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2.2,
                        height: MediaQuery.of(context).size.width / 2.2,
                        child: Image.asset(_image!=null?_image.path:"assets/images/pro3.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              _getTextFields(_email, _password, _name),
              _getSignUp(_email, _password, _name, context, uploadPic),
              _getBottomRow(context),
            ],
          ),
        ),
      ],
    );
  }
}

_getBottomRow(context) {
  return Expanded(
    flex: 1,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: Text(
            'Already have an account?\nSign In',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: cons.appTextColor,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ],
    ),
  );
}

void addUser(email, fullname,uploadPic) async {
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
  DocumentReference documentReference =
      Firestore.instance.collection('users').document(firebaseUser.uid);
  // Call the user's CollectionReference to add a new user
  return documentReference
      .setData({
        'fullname': fullname, // John Doe
        'email': email,
      })
      .then((value) => uploadPic())
      .catchError((error) => print("Failed to add user: $error"));
}

_getSignUp(_email, _password, _name, context,uploadPic) {
  return FlatButton(
    onPressed: () async {
      if (_email.text.toString() != null &&
          _email.text.toString().length > 0 &&
          _password.text.toString() != null &&
          _password.text.toString().length > 0 &&
          _name.text.toString() != null &&
          _name.text.toString().length > 0) {
        FirebaseAuth auth = FirebaseAuth.instance;
        final AuthResult authResult = await auth.createUserWithEmailAndPassword(
            email: _email.text, password: _password.text);
        if (authResult.additionalUserInfo.isNewUser != null) {
          print("${_email.text} has been Register..");
          addUser(_email.text, _name.text,uploadPic);

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginScreen())); //Goto Login Screen
        }
      } else {
        print("Add all the fields..........");
      }
    },
    child: Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Sign up',
            style: TextStyle(
                color: cons.appTextColor,
                fontSize: 25,
                fontWeight: FontWeight.w500),
          ),
          CircleAvatar(
            backgroundColor: Colors.grey.shade800,
            radius: 40,
            child: Icon(
              Icons.arrow_forward,
              color: cons.appTextColor,
            ),
          ),
        ],
      ),
    ),
  );
}

_getTextFields(_email, _password, _name) {
  return Expanded(
    flex: 3,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 15,
        ),
        TextField(
          controller: _name,
          decoration: InputDecoration(
              hintText: "John Smith",
              icon: Icon(
                Icons.person,
                color: cons.appTextColor,
              ),
              hintStyle: TextStyle(color: cons.appHintColor),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: cons.appTextColor)),
              labelText: 'Name',
              labelStyle: TextStyle(color: cons.appTextColor)),
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          controller: _email,
          decoration: InputDecoration(
              hintText: "example@email.com",
              icon: Icon(
                Icons.email,
                color: cons.appTextColor,
              ),
              hintStyle: TextStyle(color: cons.appHintColor),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: cons.appTextColor)),
              labelText: 'Email',
              labelStyle: TextStyle(color: cons.appTextColor)),
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          controller: _password,
          decoration: InputDecoration(
              icon: Icon(
                Icons.lock,
                color: cons.appTextColor,
              ),
              hintText: "Password",
              hintStyle: TextStyle(color: cons.appHintColor),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: cons.appTextColor)),
              labelText: 'Password',
              labelStyle: TextStyle(color: cons.appTextColor)),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    ),
  );
}

_getHeader() {
  return Expanded(
    flex: 2,
    child: Container(
      alignment: Alignment.bottomLeft,
      child: Text(
        'Create\n       Account',
        style: TextStyle(
            color: cons.appTextColor,
            fontSize: 50,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}

_getImage(context) {
  return;
}
