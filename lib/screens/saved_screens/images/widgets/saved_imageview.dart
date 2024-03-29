import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:provider/provider.dart';

import '../../../../Constants/deleteFile.dart';
import '../../../../provider/getSavedDataProvider.dart';

  Future<void> refreshImageData(BuildContext context) async {
    // Add logic to refresh your data here, for example, fetching new data from the server
    Provider.of<GetSavedDataProvider>(context, listen: false)
        .getSavedData(".jpg");
  }

class SavedImageView extends StatelessWidget {
  final _key = GlobalKey<ExpandableFabState>();
  final String imagePath;
  SavedImageView({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              fit: BoxFit.contain,
              image: FileImage(
                File(imagePath),
              ),
            ),
          ),
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
              DeleteFile.deleteFile(context, imagePath);
              refreshImageData(context);
              Navigator.pop(context);
              
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
             
              FlutterNativeApi.shareImage(imagePath);
              log("share");
            },
          ),
        ],
      ),
    );
  }

 
}
