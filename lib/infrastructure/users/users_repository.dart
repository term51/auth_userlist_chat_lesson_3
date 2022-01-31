import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersRepository {
  final CollectionReference _userCollection;

  UsersRepository({
    CollectionReference? userCollection,
  }) : _userCollection = userCollection ?? FirebaseFirestore.instance.collection('user-collection');

  Future<void> updateUser({
    required String userId,
    required String username,
    required String firstname,
    required String lastname,
    required String phone,
  }) async {
    try {
      await _userCollection.doc(userId).update({
        'username': username,
        'firstname': firstname,
        'lastname': lastname,
        'phone': phone,
      });
    } catch (e) {
      print("Failed to update user: $e");
    }
  }

  Future<void> addUser({
    required String username,
    required String firstname,
    required String lastname,
    required String phone,
  }) async {
    try {
      await _userCollection.add({
        'username': username,
        'firstname': firstname,
        'lastname': lastname,
        'phone': phone,
      });
    } catch (e) {
      print("Failed to add user: $e");
    }
  }

  Future<void> deleteUser({
    required String userId,
  }) async {
    try {
      await _userCollection.doc(userId).delete();
    } catch (e) {
      print("Failed to delete user: $e");
    }
  }

  Future<DocumentSnapshot> getUser({String? userId}) {
    return _userCollection.doc(userId).get();
  }

  Stream<QuerySnapshot> getUsers({String? userId}) {
    return FirebaseFirestore.instance.collection('user-collection').snapshots();
  }
}
