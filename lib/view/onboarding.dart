import 'package:concentric_transition/page_view.dart';
import 'package:flutter/material.dart';
import 'package:incognito_connect/incognito_connect/home_screen.dart';
import 'package:incognito_connect/model/onboarding_contents.dart';
import 'package:incognito_connect/widget/mainPage_widget.dart';


class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: ConcentricPageView(
        itemBuilder: (index) {
          final page = contents[index % contents.length];
          return SafeArea(
            
              child: MainPageWidget(
            page: page,
            index: index,
          ));
        },
        nextButtonBuilder: (context) => const Icon(
          Icons.arrow_forward,
          color: Colors.black,
        ),
        colors: const [
          Color(0xFFd5e3d6),
          Color(0xFFffffff),
          Color(0xFF14554f),
        ],
      ),
    );
  }
}
