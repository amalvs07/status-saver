import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_saver/provider/getSavedDataProvider.dart';
import 'package:status_saver/utils/videoThumbital.dart';

import 'saved_videoview.dart';



class SavedVideoGridView extends StatelessWidget {
  bool _isFetachable = false;
  SavedVideoGridView({super.key, required this.color});
  Color color;

  @override
  Widget build(BuildContext context) {
    return Consumer<GetSavedDataProvider>(builder: (context, file, _) {
      if (_isFetachable == false) {
        file.getSavedData(".mp4");
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

      return file.getVideos.isEmpty
              ? const Center(
                  child: Text("No Video Downloaded"),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10),
                  child: GridView.extent(
                      maxCrossAxisExtent: 200,
                      crossAxisSpacing: 8.0,
                      childAspectRatio: 4/6,
                      mainAxisSpacing: 8.0,
                      children: List.generate(file.getVideos.length, (index) {
                        final data = file.getVideos[index];
                        return FutureBuilder<String>(
                            future: getThumbnail(data.path),
                            builder: (context, snapshot) {
                              return snapshot.hasData
                                  ? GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ctx) => SavedVideoView(VideoPath: data.path,),
                                        ),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(
                                              File(snapshot.data!),
                                            ),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: color,
                                        ),
                                      ),
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.green,
                                      ),
                                    );
                            });
                      })),
                );
    });
  }
}
