import 'package:flutter/material.dart';

class GalleryOne extends StatefulWidget {
  const GalleryOne({super.key});

  @override
  State<GalleryOne> createState() => _GalleryOneState();
}

class _GalleryOneState extends State<GalleryOne> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is Gallery One'),
          ],
        ),
      ),
    );
  }
}
