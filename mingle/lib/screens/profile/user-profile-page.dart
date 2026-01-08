import 'package:flutter/material.dart';
import 'package:mingle/styles/login-register-bg.dart';
import 'package:mingle/components/mingle-title.dart';
import 'package:mingle/styles/colors.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Map<String, String> profile = {
    "name": "Jamie",
    "description": "Fashion enthusiast who loves sustainable style.",
    "image": "https://randomuser.me/api/portraits/women/44.jpg",
    "xrp balance": "10",
  };

  void updateBalance(String newBalance) {
    setState(() {
      profile["xrp balance"] = newBalance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: mingleTitle(size: 30),
      ),
      body: LoginRegisterBg(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Profile Picture
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                profile["image"]!,
                width: 375,
                height: 375,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 32),

            /// Name
            Text(
              profile["name"]!,
              style: const TextStyle(
                fontSize: 40, 
                fontWeight: FontWeight.bold
              ),
            ),

            const SizedBox(height: 12),

            /// Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                profile["description"]!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22, 
                  color: black
                ),
              ),
            ),

            const SizedBox(height: 64),

            /// XRP Balance
            Text(
              "XRP Balance: ${profile["xrp balance"]!} XRP",
              style: const TextStyle(
                fontSize: 26, 
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
      ),
    );
  }
}

