import 'package:flutter/material.dart';
import 'package:mingle/styles/login-register-bg.dart';
import 'package:mingle/components/mingle-title.dart';
import 'package:mingle/styles/colors.dart';

class RestaurantProfilePage extends StatelessWidget {
  RestaurantProfilePage({super.key});

  //Replace with getProfile or sth
  final Map<String, String> restaurantProfile = {
    "name": "The Fancy Fork",
    "description": "A cozy place serving modern fusion cuisine.",
    "image": "https://icon-library.com/images/restaurant-icon-png/restaurant-icon-png-15.jpg",
  };

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
            /// Restaurant Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16), // slightly rounded square
              child: Image.network(
                restaurantProfile["image"]!,
                width: 375,
                height: 375,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 32),

            /// Restaurant Name
            Text(
              restaurantProfile["name"]!,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            /// Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                restaurantProfile["description"]!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  color: black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
