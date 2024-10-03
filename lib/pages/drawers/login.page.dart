import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as converter;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_flutter/pages/dashboard/dashboard.page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String userName = "";
  String userEmail = "";
  String userPhone = "";
  String userAddress = "";
  String userImage = "";

  //* identity for TextField
  final TextEditingController userEmailCtrl = TextEditingController();
  final TextEditingController userPasswordCtrl = TextEditingController();

  //* URL of REST API
  final String apiUrl = "http://192.168.1.12/flutter-api/users/";

  //* method for login check
  void loginCheck() async {
    // SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    var params =
        "signin.php?user_email=${userEmailCtrl.text}&user_password=${userPasswordCtrl.text}";

    try {
      var resp = await http.get(Uri.parse(apiUrl + params));
      if (resp.statusCode == 200) {
        var respConvert = converter.json.decode(resp.body);
        if (respConvert["status"] == "OK") {
          prefs.setBool("login", true);
          setState(() {
            userName = respConvert["data"][0]["user_name"].toString();
            userEmail = respConvert["data"][0]["user_email"].toString();
            userPhone = respConvert["data"][0]["user_phone"].toString();
            userAddress = respConvert["data"][0]["user_address"].toString();
            userImage = respConvert["data"][0]["image_path"].toString();
          });
          debugPrint('RESPONSE: $userName');

          //* redirect to dashboard page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardPage(
                userName: userName,
                userEmail: userEmail,
                userPhone: userPhone,
                userAddress: userAddress,
                userImage: userImage,
              ),
            ),
          );
        } else {
          debugPrint('RESPONSE: ${respConvert["message"]}');
        }
      }
    } catch (e) {
      debugPrint('ERROR: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var labelStyle = const TextStyle(
        fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700);
    var labelStyleWhite = const TextStyle(
        fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text('User Email', style: labelStyle),
                const Padding(padding: EdgeInsets.only(bottom: 8)),
                TextField(
                  controller: userEmailCtrl,
                  decoration: InputDecoration(
                    hintText: 'Enter email address',
                    border: InputBorder.none,
                    fillColor: Colors.grey.shade300,
                    filled: true,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text('User Password', style: labelStyle),
                const Padding(padding: EdgeInsets.only(bottom: 8)),
                TextField(
                  controller: userPasswordCtrl,
                  decoration: InputDecoration(
                    hintText: 'Enter password',
                    border: InputBorder.none,
                    fillColor: Colors.grey.shade300,
                    filled: true,
                  ),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 24)),
          GestureDetector(
            onTap: loginCheck,
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 128, 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text('Login', style: labelStyleWhite),
            ),
          ),
        ],
      ),
    );
  }
}
