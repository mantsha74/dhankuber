import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserUploadService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  /// Creates a user profile in Firestore if it doesn't already exist
  Future<void> createUserProfileIfNotExists() async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    final uid = user.uid;
    final phone = user.phoneNumber ?? '';
    final docRef = _db.collection('users').doc(uid);

    final doc = await docRef.get();

    if (!doc.exists) {
      await docRef.set({
        'uid': uid,
        'phone': phone,
        'name': '', // you can ask for name later and update it
        'email': '', // optional, can add later
        'referredBy': null,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print("✅ User profile created for $phone");
    } else {
      print("ℹ️ User profile already exists");
    }
  }
}
