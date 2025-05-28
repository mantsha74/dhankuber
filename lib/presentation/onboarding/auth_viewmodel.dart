import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final phoneAuthProvider = StateNotifierProvider<PhoneAuthViewModel, AsyncValue<String>>(
      (ref) => PhoneAuthViewModel(),
);

class PhoneAuthViewModel extends StateNotifier<AsyncValue<String>> {
  PhoneAuthViewModel() : super(const AsyncValue.data(''));

  late String _verificationId;

  String get verificationId => _verificationId;

  Future<void> sendOtp(String phoneNumber) async {
    state = const AsyncValue.loading();

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91$phoneNumber',
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // optional: auto sign-in on some devices
        },
        verificationFailed: (FirebaseAuthException e) {
          state = AsyncValue.error(e.message ?? 'Verification failed', StackTrace.current);
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          state = AsyncValue.data(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e, st) {
      state = AsyncValue.error(e.toString(), st);
    }
  }

  Future<void> verifyOtp(String otp) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: otp,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
