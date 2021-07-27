import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../config/paths.dart';
import '../../models/failure_model.dart';
import 'base_auth_repository.dart';
import 'package:meta/meta.dart';

class AuthRepository extends BaseAuthRepository {
  final FirebaseFirestore _firebaseFirestore;
  final auth.FirebaseAuth _firebaseAuth;

  AuthRepository(
      {FirebaseFirestore? firebaseFirestore, auth.FirebaseAuth? firebaseAuth})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  @override
  Future<auth.User> signUpWithEmailAndPassword({
      required String username,
      required String email,
      required String password}) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = credential.user;
      _firebaseFirestore.collection(Paths.users).doc(user!.uid).set({
        'username': username,
        'email': email,
        'followers': 0,
        'following': 0,
      });
      return user;
    } on auth.FirebaseAuthException catch (err) {
      throw Failure(code: err.code, message: err.message!);
    } on PlatformException catch (err) {
      throw Failure(code: err.code, message: err.message!);
    }
  }

  @override
  Future<auth.User> logWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user!;
    } on auth.FirebaseAuthException catch (err) {
      throw Failure(
          code: err.code,
          message: err.message!); //invalid email , wrong password etc.
    } on PlatformException catch (err) {
      throw Failure(code: err.code, message: err.message!);
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
