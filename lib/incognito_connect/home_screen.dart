// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
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

    return Stack(
      children: [
        Image.asset(
          "assets/images/bg-incognito-2.jpg",
          fit: BoxFit.cover,
          height: screenHeight,
          width: screenWidth,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(),
              SizedBox(),
              OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.45),
                    maximumSize:
                        Size(MediaQuery.of(context).size.width / 1.3, 56),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    side: BorderSide(
                      width: 2,
                      color: Color.fromRGBO(0, 0, 0, 1).withOpacity(0.89),
                    ),
                  ),
                  onPressed: () {
                    // Stop playing the animation when the button is pressed
                    //  setState(() {
                    //   isAnimationPlaying = false;
                    //   });

                    showDialog(
                      context: context,
                      builder: (BuildContext content) => AlertDialog(
                        backgroundColor: Colors.white.withOpacity(0.82),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        title: const Text(
                          "Enter Anonymous Name",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: Form(
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
                              hintStyle: const TextStyle(color: Colors.black26),
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
                        actions: [
                          TextButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                String name = nameController.text;
                                nameController.clear();
                                //Navigator.pushReplacement(context);
                                Navigator.pushReplacement(
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
                              "Dive In",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: const Color.fromRGBO(0, 0, 0, 1)
                                    .withOpacity(0.89),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Tap to Enter ",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 0, 0, 1).withOpacity(0.89),
                          ),
                        ),
                        Icon(Icons.arrow_forward,
                            color: Color.fromRGBO(0, 0, 0, 1)
                                .withOpacity(0.89)), // your icon here
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
