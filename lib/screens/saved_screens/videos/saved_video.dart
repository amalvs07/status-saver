import 'package:flutter/material.dart';
import 'package:status_saver/screens/saved_screens/videos/widgets/saved_video_gridview.dart';

import '../../widgets/custom_video_gridview.dart';




class SavedVideoHome extends StatelessWidget {
  const SavedVideoHome({super.key});

  @override
  Widget build(BuildContext context) {
     return  SavedVideoGridView(color: Colors.white,);
  }
}