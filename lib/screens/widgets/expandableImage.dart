import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ExpandableImage extends StatefulWidget {
  final String image;

  ExpandableImage({super.key, required this.image});

  @override
  State<ExpandableImage> createState() => _ExpandableImageState();
}

class _ExpandableImageState extends State<ExpandableImage> with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  late VoidCallback animationListener;
  final List<double> doubleTapScales = <double>[1.0, 2.0];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _animation = _animationController.drive(Tween<double>(begin: 0.0, end: 0.0)); // Initialize _animation
    animationListener=(){

    };
  }

  @override
  void dispose() {
    _animationController.removeListener(animationListener);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: ExtendedImage(
          image: FileImage(
            File(widget.image),
          ),
          fit: BoxFit.contain,
          //enableLoadState: false,
          mode: ExtendedImageMode.gesture,
          initGestureConfigHandler: (state) {
            return GestureConfig(
              minScale: 0.9,
              animationMinScale: 0.7,
              maxScale: 3.0,
              animationMaxScale: 3.5,
              speed: 1.0,
              inertialSpeed: 100.0,
              initialScale: 1.0,
              inPageView: false,
              initialAlignment: InitialAlignment.center,
            );
          },
          onDoubleTap: (ExtendedImageGestureState state) {
            var pointerDownPosition = state.pointerDownPosition;
            double? begin = state.gestureDetails?.totalScale;
            double end;

            _animationController.reset();

            if (begin == doubleTapScales[0]) {
              end = doubleTapScales[1];
            } else {
              end = doubleTapScales[0];
            }

            animationListener = () {
              state.handleDoubleTap(scale: _animation.value, doubleTapPosition: pointerDownPosition);
            };
            _animation = _animationController.drive(Tween<double>(begin: begin, end: end));

            _animation.addListener(animationListener);

            _animationController.forward();
          },
        ),
      ),
    );
  }
}
