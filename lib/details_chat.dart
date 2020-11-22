import 'package:flutter/material.dart';
import 'Messages.dart';
import 'Constants.dart' as cons;
class ChatDetail extends StatefulWidget {
  final String name;
  final Image photo;

  ChatDetail({@required this.name, @required this.photo});

  _ChatDetailState createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
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
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final item = messages[index];
                        final prevItem = index > 0 ? messages[index - 1] : null;
                        final bool removeTopMargin =
                            index > 0 && (item.toMe == prevItem.toMe);
                        final double twentyPercent =
                            MediaQuery.of(context).size.width * 0.2;
                        return Container(
                            margin: EdgeInsets.only(
                                left: item.toMe ? 10.0 : twentyPercent,
                                right: item.toMe ? twentyPercent : 10.0,
                                bottom: removeTopMargin ? 0.0 : 5.0,
                                top: 5.0),
                            padding: EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 8.0, bottom: 2.0),
                            width: 100.0,
                            decoration: BoxDecoration(
                                color: item.toMe
                                    ? cons.appBackgroundColor
                                    : Color.fromRGBO(220, 248, 200, 1),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(51, 51, 51, 0.6),
                                      blurRadius: 0.0,
                                      offset: Offset(0, 0))
                                ]),
                            child: Column(
                              mainAxisAlignment: item.toMe
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(item.message,
                                      style: TextStyle(fontSize: 16)),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        item.time,
                                        style: TextStyle(
                                            fontSize: 12, color: cons.appTickColor),
                                      ),
                                      !item.toMe
                                          ? Icon(Icons.done_all,
                                          size: 16, color: cons.appTickColor)
                                          : Container()
                                    ])
                              ],
                            ));
                      },
                    ),
                  ),
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
                                    print("This is a rcord button");
                                  },
                                  child: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    child: Icon(Icons.mic, color: cons.appTextColor),
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

