import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../provider/getStatusProvider.dart';
import '../../utils/videoThumbital.dart';
import 'custom_video_view.dart';

class CustomVideoGridView extends StatelessWidget {
  bool _isFetachable = false;
  CustomVideoGridView({super.key, required this.color});
  Color color;
  Future<void> _refreshData(BuildContext context) async {
    // Add logic to refresh your data here, for example, fetching new data from the server
    Provider.of<GetStatusProvider>(context, listen: false)
        .getDirect(".mp4");
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GetStatusProvider>(builder: (context, file, _) {
      if (_isFetachable == false) {
        file.getDirect(".mp4");
        Future.delayed(const Duration(microseconds: 1), () {
         _isFetachable=true;
        });
      }
    
       return RefreshIndicator(
          onRefresh: () => _refreshData(context),
          child:
          //  file.isWhatsappAvaliable == false
          // ? Center(
          //           child: TextButton(
          //             onPressed: () {
                       
          // file.getDirect(".mp4");

         
          //             },
          //             child:  Text(
          //               'Grant Permissions',
          //               style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 16,
          //               ),
          //             ),
          //             style: TextButton.styleFrom(
          //               backgroundColor: Colors.green,
          //               padding:
          //                   EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(8),
          //               ),
          //             ),
          //           ),
          //         )
          // :
           file.getVideos.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.green,strokeAlign: 2,),
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
                ),);
    });
  }
}
