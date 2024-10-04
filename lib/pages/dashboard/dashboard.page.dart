import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_flutter/main.dart';
import 'package:simple_flutter/pages/dashboard/products/product_list.page.dart';

class DashboardPage extends StatefulWidget {
  final String userName, userEmail, userPhone, userAddress, userImage;

  const DashboardPage({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.userAddress,
    required this.userImage,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  //* all properties to display
  late String name, email, phone, address, userImage = "";

  //* method to get all properties to display from login page
  void getUserData() async {
    setState(() {
      name = widget.userName;
      email = widget.userEmail;
      phone = widget.userPhone;
      address = widget.userAddress;
      userImage = widget.userImage;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void userLogout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("login", false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const FirstClass(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: false,
        leading: const Icon(Icons.dashboard, size: 32),
        actions: [
          PopupMenuButton(
            onSelected: (menu) {
              switch (menu) {
                case "Products":
                  //* redirect to products page
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProductListPage(),
                    ),
                  );
                  break;
                case "Logout":
                  userLogout();
                  break;
              }
            },
            itemBuilder: (context) {
              return {"Products", "Logout"}.map((String menu) {
                return PopupMenuItem(
                  value: menu,
                  child: Text(menu),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(userImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1.5,
            ),
            Column(
              children: [
                Text(name),
                Text(email),
                Text(phone),
                Text(address),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
