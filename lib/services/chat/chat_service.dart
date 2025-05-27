import 'package:chaty/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  Future<void> sendMessage(String reciverId, message) async{
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderId: currentUserId,
      receiverId: reciverId,
      senderEmail: currentUserEmail,
      message: message,
      timestamp: timestamp,
    );

    List<String> ids = [currentUserId, reciverId];
    ids.sort(); // Assure que les IDs sont dans le même ordre pour éviter les doublons
    String chatRoomId = ids.join('_');  

    await _firestore.collection('ChatRooms').doc(chatRoomId).collection('Messages').add(newMessage.toMap());
  }
    Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
      List<String> ids = [userId, otherUserId];
      ids.sort(); // Assure que les IDs sont dans le même ordre pour éviter les doublons
      String chatRoomId = ids.join('_');  
      
      return _firestore.collection('ChatRooms').doc(chatRoomId).collection('Messages').orderBy('timestamp', descending: false).snapshots();
    
  }
}