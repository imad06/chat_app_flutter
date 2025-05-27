import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;
  final bool isSeen; // <-- Ajoute ce champ


  Message({
    required this.senderId,
    required this.receiverId,
    required this.senderEmail,
    required this.message,
    required this.timestamp,
    this.isSeen = false, 
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'senderEmail': senderEmail,
      'message': message,
      'timestamp': timestamp,
      'isSeen': isSeen, // <-- Ajoute ce champ
    };
  }
}