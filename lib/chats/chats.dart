import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:whatsapp_clone/Constants.dart' as cons;
import '../details_chat.dart';

class ChatsHome extends StatefulWidget {
  @override
  ChatsHomeState createState() {
    return ChatsHomeState();
  }
}


class ChatsHomeState extends State<ChatsHome> {
  FirebaseUser firebaseUser;
  String urlLink;
  getUser() async {
    FirebaseUser user =  await FirebaseAuth.instance.currentUser();
    firebaseUser = user;
  }
  getUrl(url)async{
    var Urlll = await url;
    urlLink = Urlll;
  }

  Widget buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    getUser();
    final row = Users.fromSnapshot(snapshot);
    StorageReference storageReference = FirebaseStorage.instance.ref().child(row.email).child("profilePic.jpg");
    getUrl(storageReference.getDownloadURL());
    if(firebaseUser==null)
      getUser();

    if(firebaseUser.email==row.email){
      //nothing
      return SizedBox(height: 0,);
    }else{
      return InkWell(
        onTap: () async {
          print(row.fullname);
          print("${firebaseUser.email} == ${row.email}");

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatDetail(
                      name: row.fullname, photo: (storageReference!= null && storageReference.path.contains(row.email))!= null? Image.network(urlLink,fit: BoxFit.cover,width: 40,height: 40,) : Image.asset("assets/images/pro1.png",fit: BoxFit.cover,width: 40,height: 40,))));
        },
        child: Column(
          children: <Widget>[
            Divider(
              height: 10.0,
            ),
            ListTile(
              leading: CircleAvatar(
                foregroundColor: cons.appTextColor,
                backgroundColor: cons.appTickColor,
                radius: 30.0,
                child: ClipOval(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    // child: Image.asset("assets/images/pro1.png",fit: BoxFit.cover),
                    child: (storageReference!= null && storageReference.path.contains(row.email))? Image.network(urlLink.toString(),fit: BoxFit.cover,) : Image.asset("assets/images/pro1.png",fit: BoxFit.cover),
                  ),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    row.fullname,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    row.time == null ? "" : row.time,
                    style: TextStyle(color: cons.appTickColor, fontSize: 14.0),
                  ),
                ],
              ),
              subtitle: Container(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  row.recentMsg == null ? "" : row.recentMsg,
                  style: new TextStyle(color: cons.appTickColor, fontSize: 15.0),
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        }
        return ListView(
          children: snapshot.data.documents
              .map((data) => buildListItem(context, data))
              .toList(),
        );
      },
    );
  }
}

class Users {
  final String fullname;
  String recentMsg;
  String time;
  String email;
  DocumentReference reference;

  Users.fromMap(Map<String, dynamic> map, {this.reference})
      : fullname = map['fullname'],
        email = map['email'],
        time = map['time'],
        recentMsg = map['recentMsg'];

  Users.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
