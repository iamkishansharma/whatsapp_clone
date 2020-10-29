import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatsHome extends StatefulWidget {
  @override
  ChatsHomeState createState() {
    return ChatsHomeState();
  }
}

class ChatsHomeState extends State<ChatsHome> {

  Widget buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final row = Users.fromSnapshot(snapshot);
    return InkWell(
      onTap: (){
        print(row.fullname);
      },
      child: Column(
        children: <Widget>[
          new Divider(
            height: 10.0,
          ),
          new ListTile(
            leading: new CircleAvatar(
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
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  row.fullname,
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
                new Text(
                  row.time==null?"":row.time,
                  style: new TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              ],
            ),
            subtitle: new Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: new Text(
                row.recentMsg==null?"":row.recentMsg,
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
