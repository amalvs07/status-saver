import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

class DeleteFile {
  static void deleteFile(
    BuildContext context,
    String imagePath,
  ) async {
    try {
      // Check if the file exists before attempting to delete
      File file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
        log("File deleted successfully");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(" File deleted successfully"),
          ),
        );
      } else {
        log("File not found");
      }
    } catch (e) {
      log("Error deleting file: $e");
    }
  }
}