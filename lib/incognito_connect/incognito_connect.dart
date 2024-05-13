import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'model/msg_model.dart';
import 'msg_widget/other_msg_widget.dart';
import 'msg_widget/own_msg_widget.dart';

class IncognitoConnect extends StatefulWidget {
  const IncognitoConnect({Key? key, required this.name, required this.userId})
      : super(key: key);

  final String name;
  final String userId;

  @override
  // ignore: library_private_types_in_public_api
  _IncognitoConnectState createState() => _IncognitoConnectState();
}

class _IncognitoConnectState extends State<IncognitoConnect> {
  late TextEditingController _msgController;
  late StreamSubscription<QuerySnapshot> _subscription;
  List<MsgModel> listMsg = [];
  final ScrollController _scrollController = ScrollController();
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _msgController = TextEditingController();
    _subscribeToChatMessages();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
        } else {
          setState(() {
            _opacity = 0.0;
          });
        }
      } else {
        setState(() {
          _opacity = 1.0;
        });
      }
    });
  }

  @override
  void dispose() {
    _msgController.dispose();
    _subscription.cancel();
    super.dispose();
  }

  void _subscribeToChatMessages() {
    final chatCollection = FirebaseFirestore.instance.collection('chat');
    _subscription =
        chatCollection.orderBy('timestamp').snapshots().listen((snapshot) {
      final messages =
          snapshot.docs.map((doc) => MsgModel.fromFirestore(doc)).toList();
      setState(() {
        listMsg = messages;
      });
    });
  }

  void _sendMessage(String msg, String senderName) {
    final chatCollection = FirebaseFirestore.instance.collection('chat');
    chatCollection.add({
      'type': 'ownMsg',
      'msg': msg,
      'senderName': senderName,
      'userId': widget.userId,
      'timestamp': Timestamp.now(),
    });
    _msgController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Incognito-Connect😶‍🌫️🔗',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ClipRRect(
        child: Stack(
          children: [
            Lottie.asset(
              'assets/LottieAssets/zen_background.json',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
                child: const SizedBox(),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: listMsg.length,
                    itemBuilder: (context, index) {
                      final msg = listMsg[index];
                      if (msg.sender == widget.name) {
                        return OwnMsgWidget(
                          sender: msg.sender,
                          msg: msg.msg,
                        );
                      } else {
                        return OtherMsgWidget(
                          sender: msg.sender,
                          msg: msg.msg,
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _msgController,
                          decoration: InputDecoration(
                            hintText: "Type here...",
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
        
                        // child: TextField(
                        //   controller: _msgController,
                        //   decoration: InputDecoration(hintText: 'Type here...'),
                        // ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          final msg = _msgController.text.trim();
                          if (msg.isNotEmpty) {
                            _sendMessage(msg, widget.name);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(milliseconds: 300),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: const Duration(seconds: 2),
                            curve: Curves.fastOutSlowIn,
                          );
                        },
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Color.fromRGBO(58, 58, 60, 0.2),
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 9,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
