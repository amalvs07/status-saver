import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_native_api/flutter_native_api.dart';

import 'package:whatsappsaver/screens/widgets/expandableImage.dart';

import '../../Constants/saveToFolder.dart';


class CustomImageView extends StatelessWidget {
  final _key = GlobalKey<ExpandableFabState>();
  final String imagePath;
  CustomImageView({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ExpandableImage(image: imagePath),
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
            child: const Icon(Icons.save,color: Colors.black,),
            onPressed: () {
              // ImageGallerySaver.saveFile(imagePath).then((value) {
              //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Image Saved")));
              // });

              SaveToFolder.saveFile(context, imagePath);
            },
          ),
          FloatingActionButton(
            shape: const CircleBorder(),
            heroTag: null,
            backgroundColor: Colors.white,
            child: const Icon(Icons.print,color: Colors.black,),
            onPressed: () {
              log("print");
              FlutterNativeApi.printImage(
                imagePath,
                imagePath.split('/').last,
              );
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
              FlutterNativeApi.shareImage(imagePath);
              log("share");
            },
          ),
        ],
      ),
    );
  }

 
}
