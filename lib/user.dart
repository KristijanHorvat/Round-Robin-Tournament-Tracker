import 'package:flutter/material.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserWidget extends StatelessWidget {
  final UserProfile? user;

  UserWidget({required this.user, final Key? key}) : super(key: key);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'full_name': "kiki", // John Doe
            'company': "a", // Stokes and Sons
            'age': "3" // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
  @override
  Widget build(BuildContext context) {
    final pictureUrl = user?.pictureUrl;
    // id, name, email, email verified, updated_at
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (pictureUrl != null)
        Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: CircleAvatar(
              radius: 56,
              child: ClipOval(child: Image.network(pictureUrl.toString())),
            )),
      Card(
          child: Column(children: [
        UserEntryWidget(propertyName: 'Id', propertyValue: user?.sub),
        UserEntryWidget(propertyName: 'Name', propertyValue: user?.name),
        UserEntryWidget(propertyName: 'Email', propertyValue: user?.email),
        UserEntryWidget(
            propertyName: 'Email Verified?',
            propertyValue: user?.isEmailVerified.toString()),
        UserEntryWidget(
            propertyName: 'Updated at',
            propertyValue: user?.updatedAt?.toIso8601String()),
      ])),
      TextButton(
      onPressed: addUser,
      child: Text(
        "Add User",
      ),
    )
    ]);
  }
}

class UserEntryWidget extends StatelessWidget {
  final String propertyName;
  final String? propertyValue;

  const UserEntryWidget(
      {required this.propertyName, required this.propertyValue, final Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(propertyName), Text(propertyValue ?? '')],
        ));
  }
}
