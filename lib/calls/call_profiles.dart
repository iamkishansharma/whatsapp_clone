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
    avatarUrl: "https://static.toiimg.com/photo/msid-73540687/73540687.jpg",
  ),
  new ChatModel(
    name: "Tony Stark",
    message: "Today at 4:17 pm",
    icon: Icons.call,
    statusIcon: Icons.call_missed_outgoing,
    avatarUrl:"https://static.toiimg.com/photo/msid-73540687/73540687.jpg",
  ),
  new ChatModel(
    name: "Chris Hemsworth",
    message: "Today at 4:13 pm",
    icon: Icons.videocam,
    statusIcon: Icons.call_received,
    avatarUrl:"https://static.toiimg.com/photo/msid-73540687/73540687.jpg",
  ),
  new ChatModel(
    name: "The Hulk",
    message: "Today at 6:45 am",
    icon: Icons.call,
    statusIcon: Icons.call_missed_outgoing,
    avatarUrl: "https://static.toiimg.com/photo/msid-73540687/73540687.jpg",
  ),
  new ChatModel(
    name: "John Wick",
    message: "Today at 4:00 am",
    icon: Icons.videocam,
    statusIcon: Icons.call_made,
    avatarUrl: "https://static.toiimg.com/photo/msid-73540687/73540687.jpg",
  ),
  new ChatModel(
    name: "Hell Boy",
    message: "Yesterday at 9:22 pm",
    icon: Icons.videocam,
    statusIcon: Icons.call_received,
    avatarUrl: "https://static.toiimg.com/photo/msid-73540687/73540687.jpg",
  ),
  new ChatModel(
    name: "HeyCode Inc",
    message: "Yesterday at 11:30 pm",
    icon: Icons.call,
    statusIcon: Icons.call_received,
    avatarUrl: "https://static.toiimg.com/photo/msid-73540687/73540687.jpg",
  ),
  new ChatModel(
    name: "Leonardo DiCaprio",
    message: "Yesterday at 10:17 pm",
    icon: Icons.videocam,
    statusIcon: Icons.call_received,
    avatarUrl:"https://static.toiimg.com/photo/msid-73540687/73540687.jpg",
  ),
  new ChatModel(
    name: "Elon Musk",
    message: "Yesterday at 1:17 pm",
    icon: Icons.videocam,
    statusIcon: Icons.call_received,
    avatarUrl:'https://static.toiimg.com/photo/msid-73540687/73540687.jpg',
  ),
  new ChatModel(
    name: "Jack Sparrow",
    message: "18 May, 7:47 am",
    icon: Icons.call,
    statusIcon: Icons.call_received,
    avatarUrl:"https://static.toiimg.com/photo/msid-73540687/73540687.jpg",
  ),
  new ChatModel(
    name: "NASA",
    message: "17 May, 9:47 am",
    icon: Icons.videocam,
    statusIcon: Icons.call_missed,
    avatarUrl:"https://static.toiimg.com/photo/msid-73540687/73540687.jpg",
  ),
];
