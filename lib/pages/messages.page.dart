import 'package:flutter/material.dart';
import 'package:simple_flutter/pages/tabs/chats.page.dart';
import 'package:simple_flutter/pages/tabs/privacy.page.dart';
import 'package:simple_flutter/pages/tabs/updates.page.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  var myColor = const Color.fromRGBO(0, 0, 128, 1);

  //* all tab menus
  static const List<Widget> widgetBottomNavigation = <Widget>[
    Expanded(child: ChatsPage()),
    Expanded(child: UpdatesPage()),
    Expanded(child: PrivacyPage()),
  ];

  //* tab menu first  time opened
  int selectedTabIndex = 0;

  //* change selected tab index
  void onChangeTabMenu(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        centerTitle: false,
        backgroundColor: myColor,
      ),
      body: Center(
        child: Column(
          children: [
            //* widgetBottomNavigation[selectedTabIndex],
            widgetBottomNavigation.elementAt(selectedTabIndex),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: myColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedTabIndex,
        onTap: onChangeTabMenu,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
          BottomNavigationBarItem(icon: Icon(Icons.update), label: 'Updates'),
          BottomNavigationBarItem(icon: Icon(Icons.key), label: 'Privacy'),
        ],
      ),
    );
  }
}
