import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'status_camera.dart' as status_camera;
import 'chats.dart' as chats;
import 'status.dart' as status;
import 'calls.dart' as calls;

void main() => runApp(WhatsApp());

enum Choice { group, broadcast, wweb, messages, settings }

class WhatsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WhatsAppHome(),
    );
  }
}

class WhatsAppHome extends StatefulWidget {
  final List<CameraDescription> cameras;
  WhatsAppHome({this.cameras});
  @override
  _WhatsAppHomeState createState() => _WhatsAppHomeState();
}

class _WhatsAppHomeState extends State<WhatsAppHome>
    with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    controller = new TabController(length: 4, vsync: this);
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  //This is for OptionMenu

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WhatsApp"),
        backgroundColor: Color(0xff076E64),
        bottom: TabBar(
          controller: controller,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.camera_alt,
              ),
            ),
            Tab(
              text: "CHATS",
            ),
            Tab(
              text: "STATUS",
            ),
            Tab(
              text: "CALLS",
            )
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          
          //POPUP MENU HERE
          PopupMenuButton<Choice>(
            // onSelected: (Choice res){setState(() {_seletion = res;});},
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Choice>>[
              const PopupMenuItem<Choice>(
                value: Choice.group,
                child: Text('New Group'),
              ),
              const PopupMenuItem<Choice>(
                value: Choice.broadcast,
                child: Text('New broadcast'),
              ),
              const PopupMenuItem<Choice>(
                value: Choice.wweb,
                child: Text('WhatsApp Web'),
              ),
              const PopupMenuItem<Choice>(
                value: Choice.messages,
                child: Text('Starred messages'),
              ),
              const PopupMenuItem<Choice>(
                value: Choice.settings,
                child: Text('Settings'),
              ),
            ],
          ),
        ],
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          new status_camera.StatusCameraHome(),
          new chats.ChatsHome(),
          new status.StatusHome(),
          new calls.CallsHome(),
        ],
      ),
    );
  }
}
