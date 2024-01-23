import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:status_saver/Constants/deleteFile.dart';
import 'package:video_player/video_player.dart';


class SavedVideoView extends StatefulWidget {
  String? VideoPath;
  SavedVideoView({super.key, this.VideoPath});

  @override
  State<SavedVideoView> createState() => _CustomVideoViewState();
}

class _CustomVideoViewState extends State<SavedVideoView> {
  final _key = GlobalKey<ExpandableFabState>();

  ChewieController? _chewieController;
  late VideoPlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.file(
        File(widget.VideoPath!),
      ),
      autoInitialize: true,
      autoPlay: true,
      looping: true,
      aspectRatio: 9/16,
      
    );
    _controller = VideoPlayerController.file(
      File(widget.VideoPath!),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _chewieController!.pause();
    _chewieController!.dispose();
    _controller.pause();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Chewie(
            controller: _chewieController!,
          ),
        ),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: ExpandableFab(
            key: _key,
            openButtonBuilder: RotateFloatingActionButtonBuilder(
              child: const Icon(Icons.menu),
              fabSize: ExpandableFabSize.regular,
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
              shape: const CircleBorder(),
            ),
            closeButtonBuilder: DefaultFloatingActionButtonBuilder(
              child: const Icon(Icons.close),
              fabSize: ExpandableFabSize.regular,
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
              shape: const CircleBorder(),
            ),
            children: [
              FloatingActionButton(
            shape: const CircleBorder(),
            heroTag: null,
            backgroundColor: Colors.white,
            child: const Icon(Icons.delete,color: Colors.black,),
            onPressed: () {
              log("delete");
              DeleteFile.deleteFile(context, widget.VideoPath!);
              Navigator.pop(context);
            },
          ),
             
              FloatingActionButton(
                shape: const CircleBorder(),
                heroTag: null,
                backgroundColor: Colors.white,
                child: const Icon(Icons.share,color: Colors.black,),
                onPressed: () {
                  // final state = _key.currentState;
                  // if (state != null) {
                  //   debugPrint('isOpen:${state.isOpen}');
                  //   state.toggle();
                  // }
                  FlutterNativeApi.shareImage(widget.VideoPath);
                  log("share");
                },
              ),
            ]));
  }
}
