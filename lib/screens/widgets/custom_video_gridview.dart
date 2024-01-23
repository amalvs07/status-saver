import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_saver/utils/videoThumbital.dart';

import '../../provider/getStatusProvider.dart';
import 'custom_video_view.dart';

class CustomVideoGridView extends StatelessWidget {
  bool _isFetachable = false;
  CustomVideoGridView({super.key, required this.color});
  Color color;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
      WidgetsBinding.instance.addPostFrameCallback((_) {
       Provider.of<GetStatusProvider>(context,listen: true).getDirect(".mp4");
    });
      },
      child: Consumer<GetStatusProvider>(builder: (context, file, _) {
        if (_isFetachable == false) {
          file.getDirect(".mp4");
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
                file.getDirect(
                    ".jpg"); // Try fetching again after permission is granted
              },
              child: Text(
                " Permission Needed",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
        return  file.getVideos.isEmpty
                ? const Center(
                    child: Text("No Status Avaliable"),
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
                                            builder: (ctx) => CustomVideoView(VideoPath: data.path,),
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
                                          strokeWidth: 2,
                                        ),
                                      );
                              });
                        })),
                  );
      }),
    );
  }
}
