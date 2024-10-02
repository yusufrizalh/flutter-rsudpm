import 'package:flutter/material.dart';

class GalleryThree extends StatefulWidget {
  const GalleryThree({super.key});

  @override
  State<GalleryThree> createState() => _GalleryThreeState();
}

class _GalleryThreeState extends State<GalleryThree> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is Gallery Three'),
          ],
        ),
      ),
    );
  }
}
