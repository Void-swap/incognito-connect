import 'package:cloud_firestore/cloud_firestore.dart';

class MsgModel {
  final String type;
  final String msg;
  final String sender;
  final Timestamp timestamp;

  MsgModel({
    required this.type,
    required this.msg,
    required this.sender,
    required this.timestamp,
  });

  factory MsgModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MsgModel(
      type: data['type'],
      msg: data['msg'],
      sender: data['senderName'],
      timestamp: data['timestamp'],
    );
  }
}

// Function to send a message to Firestore
Future<void> sendMessage(String messageContent, String senderName) async {
  try {
    // Get a reference to the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Add a new document with a generated ID to the "chat" collection
    await firestore.collection('chat').add({
      'content': messageContent,
      'sender': senderName,
      'timestamp': Timestamp.now(), // Add a timestamp for sorting messages
    });
  } catch (error) {
    print('Error sending message: $error');
    // Handle error appropriately, e.g., show an error message to the user
  }
}

// Function to listen for changes in the chat collection
Stream<QuerySnapshot> getChatMessages() {
  try {
    // Get a reference to the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Return a stream of snapshots for the "chat" collection
    return firestore.collection('chat').orderBy('timestamp').snapshots();
  } catch (error) {
    print('Error getting chat messages: $error');
    // Handle error appropriately, e.g., show an error message to the user
    return Stream.empty(); // Return an empty stream in case of error
  }
}
