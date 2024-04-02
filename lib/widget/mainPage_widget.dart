import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incognito_connect/incognito_connect/home_screen.dart';
import 'package:incognito_connect/model/onboarding_contents.dart';

class MainPageWidget extends StatelessWidget {
  const MainPageWidget({super.key, required this.page, required this.index});
  final OnboardingContents page;
  final int index;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          SizedBox(
              height: screenHeight * .5,
              child: Image.asset(
                page.image,
                fit: BoxFit.contain,
              )),
          SizedBox(height: screenHeight * 0.035),
          if (index == 2 || index == 5 || index == 8) 
            Column(
              children: [
                Text(
                  page.title,
                  style: GoogleFonts.merriweather(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * .07,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.025),
                Text(
                  page.desc,
                  style: GoogleFonts.playfair(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.width * .042,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          if (index != 2 && index != 5 && index != 8)
            Column(
              children: [
                Text(
                  page.title,
                  style: GoogleFonts.merriweather(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * .07,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  page.desc,
                  style: GoogleFonts.playfair(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.width * .042,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .125,
          ),
          if (index == 2 || index == 5 || index == 8)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(top: 8, right: 8),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    },
                    child: const Text(
                      "Join In",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
