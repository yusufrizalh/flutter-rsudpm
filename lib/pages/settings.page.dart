import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                for (int a = 1; a <= 20; a++)
                  SizedBox(
                    height: 120,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          )),
                      margin: const EdgeInsets.all(6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ListTile(
                            tileColor: Colors.white38,
                            dense: false,
                            selectedTileColor: Colors.blue,
                            // leading: const Icon(Icons.numbers),
                            leading: Text('$a',
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            title: Text('List item $a',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                            trailing: PopupMenuButton(
                              tooltip: 'Open options',
                              icon: const Icon(Icons.arrow_drop_down, size: 32),
                              onSelected: (index) {
                                if (index == 0) {
                                  debugPrint('Edit');
                                } else if (index == 1) {
                                  debugPrint('Delete');
                                }
                              },
                              itemBuilder: (context) {
                                return <PopupMenuEntry<int>>[
                                  const PopupMenuItem(
                                    value: 0,
                                    child: Text('Edit'),
                                  ),
                                  const PopupMenuItem(
                                    value: 1,
                                    child: Text('Delete'),
                                  ),
                                ];
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
