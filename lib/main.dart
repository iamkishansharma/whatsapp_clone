import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'package:whatsapp_clone/options_menu/settings.dart';
import 'Constants.dart' as cons;
import 'calls/calls.dart' as calls;
import 'camera/status_camera.dart' as status_camera;
import 'chats/chats.dart' as chats;
import 'status/status.dart' as status;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseUser user1 = await FirebaseAuth.instance.currentUser();
  if (user1==null) {
    print('User is currently signed out!');
    runApp(LoginScreen());
  } else {
    print('User is signed in!');
    runApp(WhatsApp());
  }
}

enum Choice { group, broadcast, wweb, messages, settings }

class WhatsApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: WhatsAppHome(),
    );
  }
}

class WhatsAppHome extends StatefulWidget {
  @override
  _WhatsAppHomeState createState() => _WhatsAppHomeState();
}

class _WhatsAppHomeState extends State<WhatsAppHome>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(length: 4, vsync: this, initialIndex: 1);
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
      backgroundColor: cons.appBackgroundColor,
      appBar: AppBar(
        title: Text("WhatsApp"),
        backgroundColor: cons.mainColor,
        bottom: TabBar(
          controller: controller,
          indicatorColor: cons.appTextColor,
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
              color: cons.appBackgroundColor,
            ),
            onPressed: () {},
          ),

          //POPUP MENU HERE
          PopupMenuButton<Choice>(
            onSelected: (Choice res) {
              setState(() {
                // _seletion = res;
                switch (res) {
                  case Choice.group: //jkl
                    break;
                  case Choice.broadcast: //jkl
                    break;
                  case Choice.wweb: //jkl
                    break;
                  case Choice.messages:
                    break;
                  case Choice.settings:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsPage()));
                }
              });
            },
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
