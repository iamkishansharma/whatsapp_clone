import 'package:flutter/material.dart';

class ChatModel {
  final String name;
  final String message;
  var icon;
  var statusIcon;
  final String avatarUrl;

  ChatModel({this.name, this.message, this.icon, this.statusIcon, this.avatarUrl});
}

List<ChatModel> dummy = [
  
  new ChatModel(
    name: "Sundar Pichai",
    message: "Today at 5:22 pm",
    icon: Icons.call,
    statusIcon: Icons.call_made,
    avatarUrl: "https://pbs.twimg.com/profile_images/864282616597405701/M-FEJMZ0.jpg",
  ),
  new ChatModel(
    name: "Tony Stark",
    message: "Today at 4:17 pm",
    icon: Icons.call,
    statusIcon: Icons.call_missed_outgoing,
    avatarUrl:"https://www.cheatsheet.com/wp-content/uploads/2020/02/Robert-Downey-Jr-2-1024x692.jpg",
  ),
  new ChatModel(
    name: "Chris Hemsworth",
    message: "Today at 4:13 pm",
    icon: Icons.videocam,
    statusIcon: Icons.call_received,
    avatarUrl:"https://pmcvariety.files.wordpress.com/2017/04/thor-ragnarok.jpg",
  ),
  new ChatModel(
    name: "The Hulk",
    message: "Today at 6:45 am",
    icon: Icons.call,
    statusIcon: Icons.call_missed_outgoing,
    avatarUrl: "https://i1.wp.com/bitcast-a-sm.bitgravity.com/slashfilm/wp/wp-content/images/hulk-avengers-fist-700x300.jpg",
  ),
  new ChatModel(
    name: "John Wick",
    message: "Today at 4:00 am",
    icon: Icons.videocam,
    statusIcon: Icons.call_made,
    avatarUrl: "http://townsquare.media/site/442/files/2016/10/John-Wick-Chapter-2.jpg",
  ),
  new ChatModel(
    name: "Hell Boy",
    message: "Yesterday at 9:22 pm",
    icon: Icons.videocam,
    statusIcon: Icons.call_received,
    avatarUrl: "https://www.vitalthrills.com/wp-content/uploads/2018/12/hellboyhorns.jpg",
  ),
  new ChatModel(
    name: "HeyCode Inc",
    message: "Yesterday at 11:30 pm",
    icon: Icons.call,
    statusIcon: Icons.call_received,
    avatarUrl: "https://www.biography.com/.image/t_share/MTY2MzU3Nzk2OTM2MjMwNTkx/elon_musk_royal_society.jpg",
  ),
  new ChatModel(
    name: "Leonardo DiCaprio",
    message: "Yesterday at 10:17 pm",
    icon: Icons.videocam,
    statusIcon: Icons.call_received,
    avatarUrl:"https://usercontent2.hubstatic.com/14785707_f520.jpg",
  ),
  new ChatModel(
    name: "Elon Musk",
    message: "Yesterday at 1:17 pm",
    icon: Icons.videocam,
    statusIcon: Icons.call_received,
    avatarUrl:'https://www.biography.com/.image/t_share/MTY2MzU3Nzk2OTM2MjMwNTkx/elon_musk_royal_society.jpg',
  ),
  new ChatModel(
    name: "Jack Sparrow",
    message: "18 May, 7:47 am",
    icon: Icons.call,
    statusIcon: Icons.call_received,
    avatarUrl:"https://s3.amazonaws.com/heights-photos.bcheights.com/wp-content/uploads/2015/09/04225427/Pirates4JackSparrowPosterCropped.jpg",
  ),
  new ChatModel(
    name: "NASA",
    message: "17 May, 9:47 am",
    icon: Icons.videocam,
    statusIcon: Icons.call_missed,
    avatarUrl:"https://banner2.cleanpng.com/20180509/clq/kisspng-nasa-insignia-logo-national-advisory-committee-for-5af2da39e26428.9819356315258650179273.jpg",
  ),
];
