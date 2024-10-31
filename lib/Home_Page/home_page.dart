import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/Home_Page/button_widget.dart';
import 'dart:async';
import 'package:travel_app/Home_Page/scrollable_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> list = [
    {
      'caption': 'Explore the new to \n find good places',
      'subCaption':
          'Travel around the world with just a tap and enjoy your best holiday',
      'imageUrl': 'assets/images/travel_img_1.jpg',
    },
    {
      'caption': 'Adventure awaits \n ✈️ ',
      'subCaption':
          "Pack your bags, book your flight, and let's explore the world together",
      'imageUrl': 'assets/images/travel_img_2.jpg',
    },
    {
      'caption': 'Lost in the beauty of nature',
      'subCaption': "Let's explore the world, one destination at a time.",
      'imageUrl': 'assets/images/travel_img_3.jpg',
    },
    {
      'caption': 'Making memories that last a lifetime 📸',
      'subCaption': 'Travel is the only thing you buy that makes you richer.',
      'imageUrl': 'assets/images/travel_img_4.jpg',
    },
  ];

  late PageController _pageController;
  late Timer _timer;
  int currentPage = 0; //* use by DotsIndicator
  int nextPage = 1; //* use by page controller

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.round(); //double to int
      });
    });

    _timer = Timer.periodic(
      const Duration(seconds: 4),
      (timer) {
        nextPage = currentPage + 1;

        if (nextPage == list.length) {
          nextPage = 0;
          currentPage = 0;
        }

        _pageController.animateToPage(
          nextPage,
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: height * 0.8,
            child: Stack(
              children: [
                PageView(
                  controller: _pageController,
                  children: list.map((iterateItem) {
                    return ScrollableScreen(
                      caption: iterateItem['caption'] ?? '',
                      subCaption: iterateItem['subCaption'] ?? '',
                      imageUrl: iterateItem['imageUrl'] ?? '',
                    );
                  }).toList(),
                ),
                Positioned(
                  bottom: height * 0.2, // Position 20 pixels above the bottom
                  left: 0,
                  right: 0,
                  child: Center(
                    child: DotsIndicator(
                      dotsCount: list.length,
                      position: currentPage.toInt(),
                      decorator: DotsDecorator(
                        shape: CircleBorder(
                          side: BorderSide(
                            color: Colors.teal,
                            width: 0.8,
                          ),
                        ),
                        color: Colors.white,
                        spacing: const EdgeInsets.all(8.0),
                        activeColor: Colors.white,
                        size: const Size(8.0, 8.0), // Size of inactive dots
                        activeSize:
                            const Size(40.0, 12.0), // Size of active dot
                        activeShape: RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.black, width: 0.1),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ButtonWidget()
        ],
      ),
    );
  }
}
