import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help and Feedback'),
        centerTitle: false,
      ),
      body: const Center(
        child: Column(
          children: [
            Text('This is help page'),
          ],
        ),
      ),
    );
  }
}
