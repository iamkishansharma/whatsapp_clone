import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../details_chat.dart';

class ChatsHome extends StatefulWidget {
  @override
  ChatsHomeState createState() {
    return ChatsHomeState();
  }
}


class ChatsHomeState extends State<ChatsHome> {
  Future<String> gett() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.email;
  }

  Widget buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final row = Users.fromSnapshot(snapshot);
    return InkWell(
      onTap: () async {
        print(row.fullname);
        print("${await gett()}  ${row.email}");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatDetail(
                    name: row.fullname, photo: "assets/images/pro1.png")));
      },
      child: Column(
        children: <Widget>[
          Divider(
            height: 10.0,
          ),
          ListTile(
            leading: CircleAvatar(
              foregroundColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.grey,
              radius: 30.0,
              child: ClipOval(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset(
                    "assets/images/pro1.png",
                    fit: BoxFit.cover,
                  ),
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
                  style: TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              ],
            ),
            subtitle: Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                row.recentMsg == null ? "" : row.recentMsg,
                style: new TextStyle(color: Colors.grey, fontSize: 15.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
