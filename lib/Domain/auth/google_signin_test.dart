import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart'; 

import 'package:cloud_firestore/cloud_firestore.dart';

Future<UserCredential?> signInWithGoogle() async {
  try {
final googleSignIn = GoogleSignIn.instance; 

    // Trigger the Google Sign-In flow
    final GoogleSignInAccount? googleUser = await googleSignIn.authenticate();
    if (googleUser == null) return null; // User cancelled

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential (accessToken is optional)
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the credential
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // Store user info to Firestore
    final user = userCredential.user;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'name': user.displayName,
        'email': user.email,
        'phone': user.phoneNumber ?? '',
        'created_at': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }

    return userCredential;
  } catch (e) {
    print('Google Sign-In failed: $e');
    return null;
  }
}
