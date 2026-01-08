import 'package:flutter/material.dart';
import 'package:mingle/components/mingle-button.dart';
import 'package:mingle/components/mingle-title.dart';
import 'package:mingle/styles/colors.dart';
import 'package:mingle/styles/login-register-bg.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int currentIndex = 0;

  //to be updated with getRandomProfile or sth
  final List<Map<String, String>> profiles = [
    {
      "name": "Alex Tan",
      "description": "Fashion enthusiast who loves sustainable style.",
      "image": "https://randomuser.me/api/portraits/men/32.jpg",
    },
    {
      "name": "Jamie Lim",
      "description": "Minimalist. Coffee addict. Thrift lover.",
      "image": "https://randomuser.me/api/portraits/women/65.jpg",
    },
    {
      "name": "Chris Wong",
      "description": "Streetwear collector & reseller.",
      "image": "https://randomuser.me/api/portraits/men/65.jpg",
    },
  ];


  void nextProfile() {
    setState(() {
      currentIndex = (currentIndex + 1) % profiles.length;
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
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Profile Picture
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                profiles[currentIndex]["image"]!,
                width: 375,
                height: 375,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 32),

            /// Name
            Text(
              profiles[currentIndex]["name"]!,
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
                profiles[currentIndex]["description"]!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22, 
                  color: black
                ),
              ),
            ),

            const SizedBox(height: 64),

            /// Buttons
            Row(
              children: [
                Expanded(
                  child: mingleButton(
                    text: "Decline",
                    onPressed: nextProfile,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: mingleButton(
                    text: "Accept",
                    onPressed: nextProfile,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
