import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ShortDetailScreen extends StatefulWidget {
  final String? ytTrailerCode;
  const ShortDetailScreen({Key? key, @required this.ytTrailerCode}) : super(key: key);

  @override
  _ShortDetailScreenState createState() => _ShortDetailScreenState();
}

class _ShortDetailScreenState extends State<ShortDetailScreen> {

  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.ytTrailerCode!,
      flags: YoutubePlayerFlags(
        hideControls: false,
        controlsVisibleAtStart: true,
        autoPlay: false,
        mute: false,
        useHybridComposition: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ytTrailerHolder(),
        ],
      ),
    );
  }

  Widget ytTrailerHolder() {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.red,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
