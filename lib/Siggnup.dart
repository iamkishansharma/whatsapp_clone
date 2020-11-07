import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Login.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            children: <Widget>[
              _getHeader(),
              _getImage(context),
              _getTextFields(_email, _password, _name),
              _getSignUp(_email, _password, _name, context),
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
              color: Colors.white,
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

void addUser(email, fullname) async {
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
  DocumentReference documentReference =
      Firestore.instance.collection('users').document(firebaseUser.uid);
  // Call the user's CollectionReference to add a new user
  return documentReference
      .setData({
        'fullname': fullname, // John Doe
        'email': email,
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

_getSignUp(_email, _password, _name, context) {
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

          addUser(_email.text, _name.text);
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
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
          ),
          CircleAvatar(
            backgroundColor: Colors.grey.shade800,
            radius: 40,
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

_getTextFields(_email, _password, _name) {
  return Expanded(
    flex: 4,
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
                color: Colors.white,
              ),
              hintStyle: TextStyle(color: Colors.white70),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              labelText: 'Name',
              labelStyle: TextStyle(color: Colors.white)),
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
                color: Colors.white,
              ),
              hintStyle: TextStyle(color: Colors.white70),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.white)),
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          controller: _password,
          decoration: InputDecoration(
              icon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: "Password",
              hintStyle: TextStyle(color: Colors.white70),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.white)),
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
        'Create\nAccount',
        style: TextStyle(
            color: Colors.white, fontSize: 60, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
_getImage(context) {
  return Expanded(
    flex: 1,
    child: GestureDetector(
      onTap: (){
        print("Image");
      },
      child: CircleAvatar(
        backgroundColor: Colors.grey,
        radius: MediaQuery.of(context).size.width/2,
        child: ClipOval(
          child: SizedBox(
            width: MediaQuery.of(context).size.width/4,
            height: 500,
            child: Image.asset(
              "assets/images/pro1.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ),
  );
}
