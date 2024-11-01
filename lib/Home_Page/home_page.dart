import 'dart:math';

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
  int currentPage = 0;
  bool isPlaying = true;

  List<Map<String, String>> get extendedList {
    return [list.last, ...list, list.first];
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);

    _pageController.addListener(() {
      int page = _pageController.page!.round();
      setState(() {
        currentPage = page - 1;
      });

      if (page == extendedList.length - 1) {
        _pageController.jumpToPage(1);
      } else if (page == 0) {
        _pageController.jumpToPage(extendedList.length - 2);
      }
    });

    startAutoSlide();
  }

  void startAutoSlide() {
    _timer = Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        if (isPlaying) {
          int nextPage = _pageController.page!.round() + 1;
          _pageController.animateToPage(
            nextPage,
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
          );
        }
      },
    );
  }

  void stopAutoSlide() {
    setState(() {
      isPlaying = false;
    });
    _timer.cancel();
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
                PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  itemCount: extendedList.length,
                  itemBuilder: (context, index) {
                    final item = extendedList[index];
                    return ScrollableScreen(
                      caption: item['caption'] ?? '',
                      subCaption: item['subCaption'] ?? '',
                      imageUrl: item['imageUrl'] ?? '',
                    );
                  },
                ),
                Positioned(
                  bottom: height * 0.2,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: DotsIndicator(
                      dotsCount: list.length, // Show only real items in dots
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
                        size: const Size(8.0, 8.0),
                        activeSize: const Size(40.0, 12.0),
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
          ButtonWidget(
            onPress: stopAutoSlide,
          ),
        ],
      ),
    );
  }
}
