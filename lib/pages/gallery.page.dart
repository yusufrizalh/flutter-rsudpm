import 'package:flutter/material.dart';
import 'package:simple_flutter/pages/tabs/galleryone.page.dart';
import 'package:simple_flutter/pages/tabs/gallerythree.page.dart';
import 'package:simple_flutter/pages/tabs/gallerytwo.page.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage>
    with TickerProviderStateMixin {
  //* all tab bars
  static const List<Widget> widgetTabBar = <Widget>[
    Expanded(child: GalleryOne()),
    Expanded(child: GalleryTwo()),
    Expanded(child: GalleryThree()),
  ];

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    //* tab bar first time opened
    tabController.animateTo(1);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gallery Page'),
          centerTitle: true,
          elevation: 12,
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 4,
            isScrollable: false,
            physics: const BouncingScrollPhysics(),
            controller: tabController,
            tabs: const <Tab>[
              Tab(icon: Icon(Icons.camera), child: Text('Gallery-1')),
              Tab(icon: Icon(Icons.photo), child: Text('Gallery-2')),
              Tab(icon: Icon(Icons.photo_camera), child: Text('Gallery-3')),
            ],
            onTap: (index) {
              debugPrint("Tab bar $index is tapped");
            },
          ),
        ),
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          controller: tabController,
          children: widgetTabBar,
        ),
      ),
    );
  }
}
