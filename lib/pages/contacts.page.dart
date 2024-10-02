import 'package:flutter/material.dart';
import 'package:simple_flutter/main.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  var myColor = Color(int.parse("0xff${'006c75'}"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const FirstClass(),
            ),
          ),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Contacts',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        backgroundColor: myColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                        'https://i.ibb.co.com/PxkfQPX/github-avatar.png'),
                    fit: BoxFit.cover),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 8, bottom: 8)),
            const CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(
                  'https://i.ibb.co.com/PxkfQPX/github-avatar.png'),
            ),
            const Padding(padding: EdgeInsets.only(top: 8, bottom: 8)),
            const Text(
              'This is contacts page',
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 8, bottom: 8)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  elevation: 12,
                  alignment: Alignment.center,
                  textStyle: const TextStyle(
                    color: Colors.white,
                  )),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('My Alert Dialog'),
                      content: const Text('This is message from alert dialog'),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      )),
                      actions: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.cancel),
                        ),
                        IconButton(
                          onPressed: () => debugPrint('Ok'),
                          icon: const Icon(Icons.check),
                        ),
                      ],
                      actionsOverflowButtonSpacing: 20,
                    );
                  },
                );
              },
              child: const Text('Click Alert Dialog'),
            ),
            const Padding(padding: EdgeInsets.only(top: 8, bottom: 8)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  elevation: 12,
                  alignment: Alignment.center,
                  textStyle: const TextStyle(
                    color: Colors.white,
                  )),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.share),
                              title: Text('Share'),
                            ),
                            ListTile(
                              leading: Icon(Icons.edit),
                              title: Text('Edit'),
                            ),
                            ListTile(
                              leading: Icon(Icons.bookmark),
                              title: Text('Bookmark'),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Click Modal Dialog'),
            )
          ],
        ),
      ),
    );
  }
}
