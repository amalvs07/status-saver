import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_saver/provider/getStatusProvider.dart';

import 'custom_image_view.dart';

class CustomImageGridView extends StatelessWidget {
  bool _isFetachable = false;
  CustomImageGridView({super.key, required this.color});
  Color color;
  Future<void> _refreshData(BuildContext context) async {
    // Add logic to refresh your data here, for example, fetching new data from the server
    Provider.of<GetStatusProvider>(context, listen: false).getDirect(".jpg");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetStatusProvider>(
      builder: (context, file, _) {
          if (_isFetachable == false) {
        file.getDirect(".jpg");
        Future.delayed(const Duration(microseconds: 1), () {
         _isFetachable=true;
        });
      }

        return RefreshIndicator(
            onRefresh: () => _refreshData(context),
            child:  file.getImages.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.green,strokeAlign: 2,),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10),
                        child: GridView.extent(
                            maxCrossAxisExtent: 200,
                            crossAxisSpacing: 8.0,
                            childAspectRatio: 4 / 6,
                            mainAxisSpacing: 8.0,
                            children:
                                List.generate(file.getImages.length, (index) {
                              final data = file.getImages[index];
                              print(data);
                              return data.path.isEmpty
                                  ? const Center(
                                      child: Text("No Image"),
                                    )
                                  : GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ctx) => CustomImageView(
                                              imagePath: data.path),
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
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: color,
                                        ),
                                      ),
                                    );
                            })),
                      ));
      },
    );
  }
}
