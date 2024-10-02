import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var myColor = Color(int.parse("0xff${'006c75'}"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: false,
        backgroundColor: myColor,
      ),
      body: const Center(
        child: Column(
          children: [
            Text('This is settings page'),
          ],
        ),
      ),
    );
  }
}
