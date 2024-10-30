import 'package:flutter/material.dart';
import 'package:travel_app/Home_Page/scrollable_screen.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  List<Map<String, String>> list = [
    {
      'caption': 'Explorer the new to \n find good place',
      'subCaption':
          'Travel around the world with just tap and enjoy your best holiday',
      'imageUrl': 'assets/images/travel_img_1.jpg',
    },
    {
      'caption': 'Explorer the new to \n find good place',
      'subCaption':
          'Travel around the world with just tap and enjoy your best holiday',
      'imageUrl': 'assets/images/travel_img_2.jpg',
    },
    {
      'caption': 'Explorer the new to \n find good place',
      'subCaption':
          'Travel around the world with just tap and enjoy your best holiday',
      'imageUrl': 'assets/images/travel_img_3.jpg',
    },
    {
      'caption': 'Explorer the new to \n find good place',
      'subCaption':
          'Travel around the world with just tap and enjoy your best holiday',
      'imageUrl': 'assets/images/travel_img_4.jpg',
    },
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: height * 0.8,
            child: PageView(
              //*use Map higher order function to iterate over list
              children: list.map((iterateItem) {
                return ScrollableScreen(
                  caption: iterateItem['caption'] ?? '',
                  subCaption: iterateItem['subCaption'] ?? '',
                  imageUrl: iterateItem['imageUrl'] ?? '',
                );
              }).toList(),
            ),
          ),
          Container(
            height: height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromARGB(255, 2, 177, 130),
                    ),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have account?",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text("Sign in",
                          style: TextStyle(
                            color: Color.fromARGB(255, 2, 177, 130),
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
