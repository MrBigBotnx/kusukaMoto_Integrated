import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUserData(String userId, Map<String, dynamic> userData) async {
    await _db.collection('users').doc(userId).set(userData);
  }

  Stream<DocumentSnapshot> getUserData(String userId) {
    return _db.collection('users').doc(userId).snapshots();
  }

  // Outros métodos para operações CRUD.

  
}
