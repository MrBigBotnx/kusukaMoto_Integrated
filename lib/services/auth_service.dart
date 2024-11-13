// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // Log In
  Future<User?> loginIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<User?> registerUser(
      String email, String password, String nome, String contato) async {
    try {
      // Verifique se o usuário já existe
      List<String> signInMethods =
          await _auth.fetchSignInMethodsForEmail(email);
      if (signInMethods.isNotEmpty) {
        print("Error: Email já está em uso.");
        return null; // Retorna null ou outra mensagem para o usuário
      }

      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;
      if (user != null) {
        // Adiciona dados extras ao Firestore
        await _db.collection('usuarios').doc(user.uid).set({
          'nome': nome,
          'email': email,
          'contato': contato,
        });
      }
      return user;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Sign In
}
