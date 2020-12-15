import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Constants.dart' as cons;
import 'package:modal_progress_hud/modal_progress_hud.dart';

final _firestore = Firestore.instance;
String other;
FirebaseUser loggedInUser;
class ChatDetail extends StatefulWidget {
  final String name;
  final Image photo;
  final String emaill;
  ChatDetail({@required this.emaill,@required this.name, @required this.photo});

  _ChatDetailState createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  String messageText;
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();
  @override
  void initState() {
    getCurrentUser();
    other = widget.emaill;
    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset:true,
          appBar: AppBar(
            backgroundColor: cons.mainColor,
            title: Row(
              children: <Widget>[
                ClipOval(
                    child: widget.photo,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text(widget.name),
                )
              ],
            ),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.videocam, color: cons.appTextColor)),
              IconButton(icon: Icon(Icons.call, color: cons.appTextColor)),
              IconButton(icon: Icon(Icons.more_vert, color: cons.appTextColor))
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  MessageStreamer(),
                  //Input field from here
                  Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 2.0),
                              decoration: BoxDecoration(
                                  color: cons.appBackgroundColor,
                                  borderRadius: BorderRadius.circular(30.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(51, 51, 51, 0.6),
                                        blurRadius: 0.0,
                                        offset: Offset(0, 0))
                                  ]),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              child: Icon(
                                                  Icons
                                                      .sentiment_very_satisfied,
                                                  color: cons.appTickColor)),
                                          onTap: () {})),
                                  Expanded(
                                    child: TextField(
                                      controller: messageTextController,
                                      onChanged: (value){
                                        messageText = value;
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Write a message',
                                          hintStyle:
                                          TextStyle(color: cons.appTickColor)),
                                    ),
                                  ),
                                  Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              child: Icon(
                                                Icons.attach_file,
                                                size: 22.0,
                                                color: cons.appTickColor,
                                              )),
                                          onTap: () {})),
                                  Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              child: Icon(Icons.camera_alt,
                                                  color: cons.appTickColor)),
                                          onTap: () {}))
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10.0),
                            child: Material(
                              color: cons.mainColor,
                              borderRadius: BorderRadius.circular(25.0),
                              child: InkWell(
                                  onTap: () {
                                    messageTextController.clear();
                                    setState(() {
                                      getCurrentUser();
                                    });
                                    _firestore.collection('messages').add({
                                      'text': messageText,
                                      'sender': loggedInUser.email,
                                      'receiver': widget.emaill,
                                    });
                                  },
                                  child: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    child: Icon(Icons.send, color: cons.appTextColor),
                                  )),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
      ),
    );
  }
}


class MessageBubble extends StatelessWidget {
  final String text;
  final String sender;
  bool isMe;
  MessageBubble({this.text, this.sender, this.isMe});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$sender',
            style: TextStyle(
              fontSize: 12.0,
              color: isMe ? Colors.black54 : Colors.black,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))
                : BorderRadius.only(
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            elevation: 5,
            color: isMe ? Colors.lightBlue : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
              child: Text(
                '$text',
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.black, fontSize: 15.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MessageStreamer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data.documents.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            final text = message.data['text'];
            final sender = message.data['sender'];
            final String receiver = message.data['receiver'];

            final currentUser = loggedInUser.email;

            if(receiver==other){
              final messageWidget = MessageBubble(
                text: text,
                sender: sender,
                isMe: currentUser == sender,
              );
              messageBubbles.add(messageWidget);
            }
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageBubbles,
            ),
          );
        } else {
          return ModalProgressHUD(
            inAsyncCall: true,
            child: Text("Haluwa"),
          );
        }
      },
    );
  }
}
