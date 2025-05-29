import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String uid;
  final String name;
  final String phone;
  final String email;
  final String photoUrl;
  final String? referredBy;
  final String? address;
  final DateTime createdAt;

  UserProfile({
    required this.uid,
    required this.name,
    required this.phone,
    required this.email,
    required this.photoUrl,
    required this.createdAt,
    this.referredBy,
    this.address,
  });

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'name': name,
    'phone': phone,
    'email': email,
    'photoUrl': photoUrl,
    'referredBy': referredBy,
    'address': address,
    'createdAt': createdAt,
  };

  factory UserProfile.fromMap(Map<String, dynamic> map) => UserProfile(
    uid: map['uid'],
    name: map['name'] ?? '',
    phone: map['phone'] ?? '',
    email: map['email'] ?? '',
    photoUrl: map['photoUrl'] ?? '',
    referredBy: map['referredBy'],
    address: map['address'],
    createdAt: (map['createdAt'] as Timestamp).toDate(),
  );

  UserProfile copyWith({
    String? name,
    String? phone,
    String? email,
    String? photoUrl,
    String? address,
    String? referredBy,
  }) {
    return UserProfile(
      uid: uid,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      referredBy: referredBy ?? this.referredBy,
      address: address ?? this.address,
      createdAt: createdAt,
    );
  }
}
