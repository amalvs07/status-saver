import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_saver/provider/getSavedDataProvider.dart';

import 'saved_imageview.dart';

class SavedImageGridView extends StatelessWidget {
  bool _isFetchable = false;

  SavedImageGridView({Key? key, required this.color}) : super(key: key);

  final Color color;

  Future<void> _refreshData(BuildContext context) async {
    // Add logic to refresh your data here, for example, fetching new data from the server
    Provider.of<GetSavedDataProvider>(context, listen: false)
        .getSavedData(".jpg");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetSavedDataProvider>(
      builder: (context, file, _) {
        if (_isFetchable == false) {
          file.getSavedData(".jpg");
          Future.delayed(const Duration(microseconds: 1), () {
            _isFetchable = true;
          });
        }

        return RefreshIndicator(
          onRefresh: () => _refreshData(context),
          child:file.isWhatsappAvaliable == false
                ? Center(
                    child: TextButton(
                      onPressed: () {
                       
          file.getSavedData(".jpg");

         
                      },
                      child:  Text(
                        'Grant Permissions',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  )
                : 
           file.getImages.isEmpty
              ? const Center(
                  child: Text("No Image Downloaded"),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10),
                  child: GridView.extent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 4 / 6,
                    mainAxisSpacing: 8.0,
                    children: List.generate(file.getImages.length, (index) {
                      final data = file.getImages[index];
                      print(data);
                      return data.path.isEmpty
                          ? const Center(
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
                    }),
                  ),
                ),
        );
      },
    );
  }
}
