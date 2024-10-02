import 'package:flutter/material.dart';

class GalleryTwo extends StatefulWidget {
  const GalleryTwo({super.key});

  @override
  State<GalleryTwo> createState() => _GalleryTwoState();
}

class _GalleryTwoState extends State<GalleryTwo> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is Gallery Two'),
          ],
        ),
      ),
    );
  }
}
