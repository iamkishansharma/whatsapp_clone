import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Constants.dart' as colors;
import 'Siggnup.dart';
import 'main.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreenHome(),
    );
  }
}

class LoginScreenHome extends StatefulWidget {
  @override
  _LoginScreenHomeState createState() => _LoginScreenHomeState();
}

class _LoginScreenHomeState extends State<LoginScreenHome> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:true,
      backgroundColor: colors.mainLightColor,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              children: <Widget>[
                _getHeader(),
                _getTextFields(_email, _password),
                _getGoogleSignIn(),
                _getSignIn(_email, _password, context),
                _getBottomRow(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//sign in with google function
Future<FirebaseUser> signInWithGoogle() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  // Trigger the authentication flow
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  // Create a new credential
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  // Once signed in, return the UserCredential
  // return await FirebaseAuth.instance.signInWithCredential(credential);
  final AuthResult authResult = await auth.signInWithCredential(credential);
  FirebaseUser user = authResult.user;
  print("signed in " + user.displayName);
  return user;
}

//Google sign in widget
_getGoogleSignIn() {
  return Container(
    width: 300,
    alignment: AlignmentDirectional.center,
    height: 50,
    child: FlatButton(
      textColor: colors.appTextColor,
      color: colors.appBackgroundColor,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Image.asset(
          "assets/images/googlelo.png",
          alignment: AlignmentDirectional.center,
        ),
      ),
      onPressed: () async {
        signInWithGoogle(); //signin with google
        //Goto Home Screen
      },
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
    ),
  );
}

//don't have account and Password Reset Widget
_getBottomRow(BuildContext context) {
  return Expanded(
    flex: 1,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: Text(
            "Don't have an Account \nSign Up",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.appTextColor,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            // Navigator.pushReplacement(//goto SignUp screen
            //     context, MaterialPageRoute(builder: (context) => PasswordReset()));
          },
          child: Text(
            'Forget password?\nReset',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.appBackgroundColor,
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

//Email & Password sign in button widget
_getSignIn(_email, _password, context) {
  return FlatButton(
    onPressed: () async {
      if (_email.text.toString() != null &&
          _email.text.toString().length > 0 &&
          _password.text.toString().length > 0 &&
          _password.text.toString() != null) {
        AuthResult authResult;
        FirebaseAuth auth = FirebaseAuth.instance;

        try {
          authResult = await auth.signInWithEmailAndPassword(
              email: _email.text, password: _password.text);
        } catch (e) {
          if (e.code == 'user-not-found') {
            //signUp first
            Navigator.pushReplacement(
                //goto main screen
                context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          } else if (e.code == 'wrong-password') {
            print('Wrong password provided for that user.');
          }
        }
        if (authResult != null) {
          print("${_email.text} has been Logged In..");
          FirebaseUser user = await auth.currentUser();
          //goto home
          Navigator.pushReplacement(
              //goto main screen
              context,
              MaterialPageRoute(builder: (context) => WhatsApp()));
        }
      } else {
        print("Fill the fields....................");
      }
    },
    child: Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Sign In',
            style: TextStyle(
                color: colors.appTextColor,
                fontSize: 25,
                fontWeight: FontWeight.w500),
          ),
          CircleAvatar(
            backgroundColor: Colors.grey.shade800,
            radius: 40,
            child: Icon(
              Icons.arrow_forward,
              color: colors.appTextColor,
            ),
          ),
        ],
      ),
    ),
  );
}

//TextField widgets for asking email & password
_getTextFields(_email, _password) {
  return Expanded(
    flex: 2,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 15,
        ),
        TextField(
          controller: _email,
          decoration: InputDecoration(
              hintText: "example@email.com",
              icon: Icon(
                Icons.email,
                color: colors.appTextColor,
              ),
              hintStyle: TextStyle(color: colors.appHintColor),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colors.appTextColor)),
              labelText: 'Email',
              labelStyle: TextStyle(color: colors.appTextColor)),
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          controller: _password,
          decoration: InputDecoration(
              icon: Icon(
                Icons.lock,
                color: colors.appTextColor,
              ),
              hintText: "Password",
              hintStyle: TextStyle(color: colors.appHintColor),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colors.appTextColor)),
              labelText: 'Password',
              labelStyle: TextStyle(color: colors.appTextColor)),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    ),
  );
}

_getHeader() {
  return Expanded(
    flex: 3,
    child: Container(
      alignment: Alignment.bottomLeft,
      child: Text(
        'Welcome!\nSign In',
        style: TextStyle(
            color: colors.appTextColor,
            fontSize: 60,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}
