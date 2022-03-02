import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerItem({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoPlayerController;
  int count = 0;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        videoPlayerController.play();
        videoPlayerController.setVolume(1);
      });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap:count == 0 ? (){
          videoPlayerController.setVolume(0.0);
          setState(() {
            count = 1;
          });
      } : (){
        videoPlayerController.setVolume(1.0);
        setState(() {
          count = 0;
        });
      },
      child: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Stack(
          children: [
            VideoPlayer(videoPlayerController),
          count ==1 ?  const Positioned(
                right: 20,
                top: 30,
                child: Icon(Icons.volume_off)):
              Container(
                color: Colors.transparent,
              ),
          ],
        ),
      ),
    );
  }
}
