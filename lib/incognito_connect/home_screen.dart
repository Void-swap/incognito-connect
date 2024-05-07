// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';

import 'incognito_connect.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 1.3,
              child: Lottie.asset(
                'assets/LottieAssets/groupchat_animate.json',
                repeat: true,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(38, 50, 56, 0.87),
              ),
              onPressed: () {
                // Stop playing the animation when the button is pressed
                //  setState(() {
                //   isAnimationPlaying = false;
                //   });
            
                showDialog(
                  context: context,
                  builder: (BuildContext content) => AlertDialog(
                    backgroundColor: Colors.white.withOpacity(0.89),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    title: const Text(
                      "Enter Anonymous Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Form(
                          key: formKey,
                          child: TextFormField(
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.length < 3) {
                                return "Enter a VALID NAME";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Discreet name...",
                              hintStyle:
                                  const TextStyle(color: Colors.black26),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black45),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: -110,
                          child: ClipRRect(
                            clipBehavior: Clip.none,
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            String name = nameController.text;
                            nameController.clear();
                            //Navigator.pushReplacement(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => IncognitoConnect(
                                  name: name,
                                  userId: uuid.v1(),
                                ),
                              ),
                            );
                          }
                        },
                        //style: TextButton.styleFrom(
                        //  backgroundColor:
                        // const Color.fromARGB(255, 9, 217, 36),
                        //  ),
                        child: Text(
                          "Enter Zone",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              backgroundColor: Color.fromRGBO(0, 0, 0, 0)),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: const Text(
                "Tap to Enter!!!",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color((0xFFEEF0F5))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
