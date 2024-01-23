import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../provider/getStatusProvider.dart';
import '../widgets/custom_image_gridview.dart';


class ScreenImage extends StatelessWidget {
  const ScreenImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomImageGridView(color: Colors.white,);
  }
}

