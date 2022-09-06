import 'package:bechdal_app/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/functions/functions.widgets.dart';

class FirebaseUser {
  AuthService authService = new AuthService();
  User? user = FirebaseAuth.instance.currentUser;
  Future<void> updateFirebaseUser(
      BuildContext context, Map<String, dynamic> data) {
    User? user = FirebaseAuth.instance.currentUser;
    return authService.users.doc(user!.uid).update(data).then((value) {
      customSnackBar(context: context, content: 'Location updated on database');
    }).catchError((error) {
      customSnackBar(
          context: context,
          content: 'location cannot be updated in database due to $error');
    });
  }

  Future<DocumentSnapshot> getUserData() async {
    DocumentSnapshot doc = await authService.users.doc(user!.uid).get();
    return doc;
  }

  Future<DocumentSnapshot> getSellerData(id) async {
    DocumentSnapshot doc = await authService.users.doc(id).get();
    return doc;
  }

  createChatRoom({required Map<String, dynamic> data}) {
    authService.messages.doc(data['chatroomId']).set(data).catchError((error) {
      print(error.toString());
    });
  }

  createChat({String? chatroomId, required Map<String, dynamic> message}) {
    authService.messages
        .doc(chatroomId)
        .collection('chats')
        .add(message)
        .catchError((error) {
      print(error.toString());
    });
    authService.messages.doc(chatroomId).update(
        {'lastChat': message['message'], 'lastChatTime': message['time']});
  }

  getChatDetails({String? chatroomId}) async {
    return authService.messages
        .doc(chatroomId)
        .collection('chats')
        .orderBy('time')
        .snapshots();
  }
}
