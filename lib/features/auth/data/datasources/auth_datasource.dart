import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kusuka_moto/features/auth/domain/entities/user.dart';

class AuthDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthDataSource(this.firebaseAuth, this.firestore);

  Future<Usuario?> login(String email, String password) async {
    try {
      // ignore: non_constant_identifier_names
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userDoc = await firestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .get();
      if (userDoc.exists) {
        return Usuario.fromMap(userDoc.data()!, userDoc.id);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
