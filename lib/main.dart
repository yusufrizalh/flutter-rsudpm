import 'package:flutter/material.dart';
import 'package:simple_flutter/onboarding.dart';
import 'package:simple_flutter/pages/contacts.page.dart';
import 'package:simple_flutter/pages/drawers/bookmarks.page.dart';
import 'package:simple_flutter/pages/drawers/files.page.dart';
import 'package:simple_flutter/pages/drawers/home.page.dart';
import 'package:simple_flutter/pages/drawers/shared.page.dart';
import 'package:simple_flutter/pages/drawers/trash.page.dart';
import 'package:simple_flutter/pages/gallery.page.dart';
import 'package:simple_flutter/pages/help.page.dart';
import 'package:simple_flutter/pages/messages.page.dart';
import 'package:simple_flutter/pages/settings.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    //* MaterialApp sebagai root widget
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
      ),
      title: 'Simple Flutter',
      home: const OnBoarding(),
    );
  }
}

class FirstClass extends StatefulWidget {
  const FirstClass({super.key});

  @override
  State<FirstClass> createState() => _FirstClassState();
}

class _FirstClassState extends State<FirstClass> {
  //* all menus on drawer
  static const List<Widget> widgetDrawerMenus = <Widget>[
    Expanded(child: HomePage()),
    Expanded(child: FilesPage()),
    Expanded(child: SharedPage()),
    Expanded(child: BookmarksPage()),
    Expanded(child: TrashPage()),
  ];

  //* drawer menu first time opened
  int selectedDrawerIndex = 0;

  //* change selected drawer menu
  //* setState() is used to change state of the drawer
  void onChangeDrawerMenu(int index) {
    setState(() {
      selectedDrawerIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var myColor = Color(int.parse("0xff${'8806ce'}"));
    var myBackground = Color(int.parse("0xff${'cccccc'}"));
    var myTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      drawer: Drawer(
        backgroundColor: myBackground,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            //* Drawer Header
            DrawerHeader(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: myColor,
                image: const DecorationImage(
                  image: AssetImage('assets/images/sliverappbar_header.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                        'https://i.ibb.co.com/PxkfQPX/github-avatar.png'),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 12)),
                  Text('Yusuf Rizal', style: myTextStyle),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 8)),
            //* Drawer Menu
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              selected: selectedDrawerIndex == 0,
              onTap: () {
                // redirect to home page
                onChangeDrawerMenu(0);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_copy),
              title: const Text('Files'),
              selected: selectedDrawerIndex == 1,
              onTap: () {
                // redirect to files page
                onChangeDrawerMenu(1);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Shared'),
              selected: selectedDrawerIndex == 2,
              onTap: () {
                // redirect to shared page
                onChangeDrawerMenu(2);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text('Bookmarks'),
              selected: selectedDrawerIndex == 3,
              onTap: () {
                // redirect to bookmarks page
                onChangeDrawerMenu(3);
                Navigator.of(context).pop();
              },
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Trash'),
              selected: selectedDrawerIndex == 4,
              onTap: () {
                // redirect to trash page
                onChangeDrawerMenu(4);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 260,
              actions: [
                IconButton(
                  onPressed: () => debugPrint('Search button pressed'),
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
                PopupMenuButton(
                  iconColor: Colors.white,
                  tooltip: 'Open popup menu',
                  onSelected: (String menu) {
                    switch (menu) {
                      case "Contacts":
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ContactsPage(),
                          ),
                        );
                        break;
                      case "Messages":
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const MessagesPage(),
                          ),
                        );
                        break;
                      case "Settings":
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SettingsPage(),
                          ),
                        );
                        break;
                      case "Gallery":
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const GalleryPage(),
                          ),
                        );
                        break;
                      case "Help":
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const HelpPage(),
                          ),
                        );
                        break;
                    }
                  },
                  itemBuilder: (context) {
                    return {
                      "Contacts",
                      "Messages",
                      "Settings",
                      "Gallery",
                      "Help"
                    }.map((String menu) {
                      return PopupMenuItem(
                        value: menu,
                        child: Text(menu),
                      );
                    }).toList();
                  },
                ),
              ],
              title: Text(
                'Simple Flutter',
                style: myTextStyle,
              ),
              centerTitle: true,
              backgroundColor: myColor,
              pinned: true,
              elevation: 12,
              flexibleSpace: const FlexibleSpaceBar(
                background: Image(
                  image: AssetImage('assets/images/sliverappbar_header.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              widgetDrawerMenus[selectedDrawerIndex],
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create new',
        elevation: 12,
        backgroundColor: myColor,
        foregroundColor: Colors.white,
        onPressed: () {
          var mySnackbar = SnackBar(
            content: const Text('This is message from snackbar'),
            elevation: 12,
            backgroundColor: myColor,
            duration: const Duration(seconds: 6),
            showCloseIcon: true,
            closeIconColor: Colors.white,
            behavior: SnackBarBehavior.fixed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(mySnackbar);
        },
        child: const Icon(Icons.create),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
