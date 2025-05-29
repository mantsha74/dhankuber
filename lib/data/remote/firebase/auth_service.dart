import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../domain/models/user_profile.dart';

Future<void> createUserProfileIfNotExists({String? referredBy}) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final uid = user.uid;
  final doc = FirebaseFirestore.instance.collection('users').doc(uid);
  final snapshot = await doc.get();

  if (!snapshot.exists) {
    final profile = UserProfile(
      uid: uid,
      name: '', // to be filled later
      phone: user.phoneNumber ?? '',
      email: user.email ?? '',
      photoUrl: '',
      referredBy: referredBy,
      createdAt: DateTime.now(),
    );

    await doc.set(profile.toMap());
  }
}
