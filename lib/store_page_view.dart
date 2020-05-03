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
          StoryItem.pageImage(url: "images/pro2.png", controller: controller),
          StoryItem.pageImage(url: "images/pro3.png", controller: controller),
          StoryItem.pageImage(url: "images/pro4.png", controller: controller),
        ],
      ),
    );
  }
}