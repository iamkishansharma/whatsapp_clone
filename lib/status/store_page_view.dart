import 'package:flutter/material.dart';
import "package:story_view/story_view.dart";

class StoryPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = StoryController();
    return Material(
      child: StoryView(
        controller: controller,
        inline: false,
        repeat: true, storyItems: <StoryItem>[
          StoryItem.text(title: 'If you do not make time for your wellness, you will be forced to make time for your illness.#ReadThatAgain', backgroundColor: Colors.red),
          StoryItem.pageImage(url: "images/pro1.png", controller: controller),
          StoryItem.text(title: 'I bought my dream Car today. #Very Excited!', backgroundColor: Colors.deepPurple),
          StoryItem.inlineImage(url:  "http://townsquare.media/site/442/files/2016/10/John-Wick-Chapter-2.jpg", caption: Text("#JohnWick😎🍻"), controller: controller),
        ],
      ),
    );
  }
}

class StoryPageView2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = StoryController();
    return Material(
      child: StoryView(
        controller: controller,
        inline: false,
        repeat: true, storyItems: <StoryItem>[
          StoryItem.inlineImage(url: "https://pbs.twimg.com/profile_images/864282616597405701/M-FEJMZ0.jpg", caption: Text("Jai Shree Ram"), controller: controller),
          StoryItem.pageImage(url: 'https://pmcvariety.files.wordpress.com/2017/04/thor-ragnarok.jpg', controller: controller),
          StoryItem.text(title: 'I bought my dream Car🚗 today. 🤩#VeryExcited!', backgroundColor: Colors.deepPurple),
          StoryItem.text(title: 'I love my dreams. #Proud!👩‍🦳', backgroundColor: Colors.pink),
        ],
      ),
    );
  }
}