import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Login.dart';


class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SettingsHome(),
      ),
    );
  }
}
class SettingsHome extends StatefulWidget {
  @override
  _SettingsHomeState createState() => _SettingsHomeState();
}

class _SettingsHomeState extends State<SettingsHome> {

  String btnTxt = "Logout";
  Color bg =Colors.white;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: bg,
      child: Center(
        child: RaisedButton(child: Text(btnTxt),
          onPressed: () async{
            Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.black87,
                  content: Text("This is a SnakBar Example in flutter."),
                action: SnackBarAction(
                  label: "Undo",
                  textColor: Colors.red,
                  onPressed: (){
                    setState(() {
                      btnTxt = "Undo";
                      bg = Colors.pink;
                    });
                  },
                ),
                )
              );
            await FirebaseAuth.instance.signOut();//LOGOUT
            FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
            if(firebaseUser==null){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            }
          }
        )
      ),
    );
  }
}