import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'constant.dart';

class SaveToFolder {
  static void saveFile(
    BuildContext context,
    String imagePath,
  ) async {
    // Extract the file name from the image path
    String fileName = imagePath.split('/').last;

    // Copy the image to the specified folder
    File newFile = File('${AppConstants.NewPath}/$fileName');
    await File(imagePath).copy(newFile.path);

    // Show a snackbar or perform any other actions to notify the user
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(" Saved Successfully"),
      ),
    );
    log("in Function");
  }

  
}
