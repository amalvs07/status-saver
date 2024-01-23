import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_saver/provider/getSavedDataProvider.dart';

import 'saved_imageview.dart';




class SavedImageGridView extends StatelessWidget {
  bool _isFetachable = false;
  SavedImageGridView({super.key, required this.color});
  Color color;

  @override
  Widget build(BuildContext context) {
    return Consumer<GetSavedDataProvider>(
      builder: (context, file, _) {
        if (_isFetachable == false) {
          file.getSavedData(".jpg");
          Future.delayed(const Duration(microseconds: 1), () {
            _isFetachable = true;
          });
        }
 if (file.isWhatsappAvaliable == false) {
          return Center(
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)),
              onPressed: () {
                // Open app settings to grant storage permission
                file.getSavedData(
                    ".jpg"); // Try fetching again after permission is granted
              },
              child: Text(
                " Permission Needed",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
        return  file.getImages.isEmpty
                ? const Center(
                    child: Text("No Image Downloaded"),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    child: GridView.extent(
                        maxCrossAxisExtent: 200,
                        crossAxisSpacing: 8.0,
                         childAspectRatio: 4/6,
                        mainAxisSpacing: 8.0,
                        children: List.generate(file.getImages.length, (index) {
                          final data = file.getImages[index];
                          print(data);
                          return data.path.isEmpty
                              ?const Center(
                                  child: Text("No Image"),
                                )
                              : GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) =>
                                          SavedImageView(imagePath: data.path),
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(
                                          File(data.path),
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                      color: color,
                                    ),
                                  ),
                                );
                        })),
                  );
      },
    );
  }
}
