import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'example_app.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {

   await dotenv.load();
await Firebase.initializeApp(
  options: FirebaseOptions(
      apiKey: "AIzaSyBZj5sMxao2ZB4MVUDB-P3lWdIRFSyGo20",
      appId: "1:525087708940:web:1a20ed1da80475edfa1b29",
      messagingSenderId: "525087708940",
      projectId: "dz1app",
    ),
);
  runApp(const ExampleApp());
}

