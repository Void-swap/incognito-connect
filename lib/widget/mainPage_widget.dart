import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incognito_connect/incognito_connect/home_screen.dart';
import 'package:incognito_connect/model/onboarding_contents.dart';

class MainPageWidget extends StatelessWidget {
  MainPageWidget({super.key, required this.page, required this.index});
  final OnboardingContents page;
  final int index;
  final List<int> isPage3 = [2, 5, 8, 11, 14, 17, 20, 23];

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Padding(
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
            if (isPage3.contains(index))
              Column(
                children: [
                  Text(
                    page.title,
                    style: GoogleFonts.merriweather(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: screenwidth * .07,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  Text(
                    page.desc,
                    style: GoogleFonts.playfair(
                      color: Colors.white54,
                      fontWeight: FontWeight.w600,
                      fontSize: screenwidth * .042,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            if (!isPage3.contains(index))
              Column(
                children: [
                  Text(
                    page.title,
                    style: GoogleFonts.merriweather(
                      fontWeight: FontWeight.bold,
                      fontSize: screenwidth * .07,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    page.desc,
                    style: GoogleFonts.playfair(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                      fontSize: screenwidth * .042,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            SizedBox(
              height: screenHeight * .125,
            ),
            if (isPage3.contains(index))
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6, right: 6),
                    child: OutlinedButton(
                      style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                        width: 2,
                        color: Colors.white70,
                      )),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Join In ",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.white70),
                        ),
                      ),
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
