import 'package:flutter/material.dart';
import 'call_profiles.dart';
import 'package:whatsapp_clone/Constants.dart' as cons;

class CallsHome extends StatefulWidget {
  @override
  _CallsHomeState createState() => _CallsHomeState();
}

class _CallsHomeState extends State<CallsHome> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummy.length,
      itemBuilder: (context, i) =>
      new Column(
        children: <Widget>[
          new Divider(
            height: 10.0,
          ),
          new ListTile(
            leading: new CircleAvatar(
              foregroundColor: cons.appTickColor,
              backgroundColor: cons.appTickColor,
              radius: 30.0,
              child: ClipOval(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.network(dummy[i].avatarUrl, fit: BoxFit.cover,),
                ),
              ),
            ),

            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  dummy[i].name,
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
                new Icon(dummy[i].icon, color: cons.mainColor,),
              ],
            ),

            subtitle: new Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: new Row(
                children: <Widget>[
                  new Icon(dummy[i].statusIcon, color: cons.mainColor,),
                  new Text(
                    dummy[i].message,
                    style: new TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
