import 'package:flutter/material.dart';
import 'package:youtube_player_embed/youtube_player_embed.dart';

class ReproduccionScreen extends StatelessWidget {
  final String videoId;
  const ReproduccionScreen({Key? key, required this.videoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reproducción del trailer')),
      body: Center(
        child: YoutubePlayerView(
          videoId: videoId,
          autoPlay: true,
          mute: false,
          enabledShareButton: false,
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }
}
