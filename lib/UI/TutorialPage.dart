import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// Zobrazuje videotutorial z youtube
class TutorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId("https://youtu.be/AIIBdFTM2b0"),
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    return YoutubePlayer(
      controller: _controller,
    );
  }
}