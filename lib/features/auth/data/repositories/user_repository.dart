import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository(this._firestore);

  CollectionReference<Map<String, dynamic>>
  get _usersRef => _firestore.collection('users');

  Future<void> createUser(UserModel user) async {
    await _usersRef.doc(user.id).set({
      ...user.toJson(),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<UserModel?> getUserById(String id) async {
    final doc = await _usersRef.doc(id).get();
    if (!doc.exists || doc.data() == null) return null;
    return UserModel.fromJson(doc.data()!);
  }

  Future<void> updateUser(UserModel user) async {
    await _usersRef.doc(user.id).update({
      ...user.toJson(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateDisplayName(
      String id,
      String displayName,
      ) async {
    await _usersRef.doc(id).update({
      'display_name': displayName,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteUser(String id) async {
    await _usersRef.doc(id).delete();
  }
}
