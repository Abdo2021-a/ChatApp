import 'dart:io';

import 'package:chatapp/View/AuthScreen/auth_screen_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

class Auth {
  static authLoginSignup({
    File userimage,
    String email,
    String password,
    String username,
    bool islogin,
    BuildContext ctx,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      if (islogin == true) {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        UserCredential userCredential = await auth
            .createUserWithEmailAndPassword(email: email, password: password);
        final ref = await FirebaseStorage.instance
            .ref()
            .child("User_image")
            .child("${userCredential.user.uid + ".jpg"}");
        await ref.putFile(userimage);
        final urlpicture = await ref.getDownloadURL();

        FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.user.uid)
            .set({
          "email": email,
          "username": username,
          "password": password,
          "imageurl": urlpicture,
        });
      }
    } on FirebaseAuthException catch (e) {
      String message = 'wrong with your email or password enter again';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
        print('The account already exists for that email.');
      } else if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
        print('Wrong password provided for that user.');
      } else if (e.code == 'The email address is badly formatted.') {
        message = 'enter your email agian';
        print('enter your email agian');
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.black26,

//         Theme.of(ctx).splashColor,
      ));
      throw message;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}


// try {

// } on FirebaseAuthException catch (e) {
//   if (e.code == 'user-not-found') {
//     print('No user found for that email.');
//   } else if (e.code == 'wrong-password') {
//     print('Wrong password provided for that user.');
//   }
// }