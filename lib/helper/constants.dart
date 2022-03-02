import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_tutorial/controllers/auth_controller.dart';
import 'package:tiktok_tutorial/views/add_video_screen.dart';
import 'package:tiktok_tutorial/views/chat_screen.dart';
import 'package:tiktok_tutorial/views/profile_screen.dart';
import 'package:tiktok_tutorial/views/search_screen.dart';
import 'package:tiktok_tutorial/views/video_screen.dart';

List pages = [
  VideoScreen(),
  SearchScreen(),
  const AddVideoScreen(),
  const ChatScreen(),
  ProfileScreen(uid: authController.user.uid),
];



// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red;
const borderColor = Colors.grey;




// FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var fireStore = FirebaseFirestore.instance;

// CONTROLLER
var authController = AuthController.instance;
