import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:online_classroom/constants/dimensions.dart';

// ignore: must_be_immutable
class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({super.key, required this.video});

  File video;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool isPlaying = false, isAvailable = false;

  @override
  void initState() {
    _controller = VideoPlayerController.file(widget.video)
      ..initialize().then((value) => setState(
            () {},
          ));
    super.initState;
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(context) * 0.45,
      width: double.infinity,
      color: Colors.redAccent,
      child: content(),
    );
  }

  Widget content() {
    if (!_controller.value.isInitialized) {
      return Container();
    }
    return VideoPlayer(_controller);
  }
}
