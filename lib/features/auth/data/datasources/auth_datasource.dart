import 'package:firebase_auth/firebase_auth.dart';

class AuthDataSource {
  final FirebaseAuth firebaseAuth;

  AuthDataSource(this.firebaseAuth);

  Future<User?> login(String email, String password) async {
    try {
      // ignore: non_constant_identifier_names
      final UserCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return UserCredential.user;
    } catch (e) {
      return null;
    }
  }
}
