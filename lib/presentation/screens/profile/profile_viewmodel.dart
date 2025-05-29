import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/user_profile.dart';

final userProfileProvider = StateNotifierProvider<UserProfileViewModel, UserProfile>(
      (ref) => UserProfileViewModel(),
);

class UserProfileViewModel extends StateNotifier<UserProfile> {
  UserProfileViewModel() : super(_empty) {
    _loadUser();
  }

  static final _empty = UserProfile(
    uid: '',
    name: '',
    phone: '',
    email: '',
    photoUrl: '',
    address: '',
    createdAt: DateTime.now(),
  );

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> _loadUser() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      debugPrint(doc.data().toString());
      state = UserProfile.fromMap(doc.data()!);
    }
  }

  void updateField(String field, dynamic value) {
    switch (field) {
      case 'name':
        state = state.copyWith(name: value);
        break;
      case 'email':
        state = state.copyWith(email: value);
        break;
      case 'photoUrl':
        state = state.copyWith(photoUrl: value);
        break;
      case 'address':
        state = state.copyWith(address: value);
        break;
    }
  }

  Future<void> saveProfile() async {
    if (state.uid.isEmpty) return;
    await _firestore.collection('users').doc(state.uid).update(state.toMap());
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
