import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dispatcher/pages/auth.dart';
import 'package:flutter_dispatcher/pages/main_screen.dart';
import 'package:flutter_dispatcher/global.dart' as globals;
import 'package:flutter_dispatcher/pages/profile.dart';
import 'package:flutter_dispatcher/pages/reg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyC5FTuZaR1QXoH7ov9LOIyamMD05su01yo',
    appId: '1:714014044730:android:38d21fa2f32b92ff30fb03',
    messagingSenderId: '714014044730',
    projectId: 'flutter-dispatcher',
    storageBucket: 'flutter-dispatcher.appspot.com',
  ));

  if (FirebaseAuth.instance.currentUser != null) {
    globals.currentUser = await FirebaseFirestore.instance
        .collection('profiles')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const MainScreen(),
      '/auth': (context) => const AuthPage(),
      '/reg': (context) => const RegistrationPage(),
      '/profile': (context) => const ProfilePage(),
    },
  ));
}
