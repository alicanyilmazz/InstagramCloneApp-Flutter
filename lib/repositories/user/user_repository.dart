import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constant/enums/notification_type_enum.dart';
import '../../models/models.dart';
import 'package:meta/meta.dart';

import '../../config/paths.dart';
import '../../models/user_model.dart';
import 'base_user_repository.dart';

class UserRepository extends BaseUserRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<User> getUserWithId({required String userId}) async {
    final doc =
        await _firebaseFirestore.collection(Paths.users).doc(userId).get();
    return doc.exists ? User.fromDocument(doc) : User.empty;
  }

  @override
  Future<void> updateUser({required User user}) async {
    await _firebaseFirestore
        .collection(Paths.users)
        .doc(user.id)
        .update(user.toDocument());
  }

  @override
  Future<List<User>> searchUsers({required String query}) async {
    final userSnap = await _firebaseFirestore
        .collection(Paths.users)
        .where('username', isGreaterThanOrEqualTo: query)
        .get();
    return userSnap.docs.map((doc) => User.fromDocument(doc)).toList();
  }

  @override
  void followUser({required String userId, required String followUserId}) {
    // Add followUser to users's userFollowing.
    _firebaseFirestore
        .collection(Paths.following)
        .doc(userId)
        .collection(Paths.userFollowing)
        .doc(followUserId)
        .set({});
    // Add user to followUser's userFollowers.
    _firebaseFirestore
        .collection(Paths.followers)
        .doc(followUserId)
        .collection(Paths.userFollowers)
        .doc(userId)
        .set({});

    //Notifications
    final notification = Notif(
      type: NotificationType.follow,
      fromUser: User.empty.copyWith(id: userId),
      date: DateTime.now(),
    );

    _firebaseFirestore
        .collection(Paths.notifications)
        .doc(followUserId)
        .collection(Paths.userNotifications)
        .add(notification.toDocument());
  }

  @override
  Future<bool> isFollowing(
      {required String userId, required String otherUserId}) async {
    // is otherUser in user's userFollowing
    final otherUserDoc = await _firebaseFirestore
        .collection(Paths.following)
        .doc(userId)
        .collection(Paths.userFollowing)
        .doc(otherUserId)
        .get();

    return otherUserDoc.exists;
  }

  @override
  void unfollowUser(
      {required String userId, required String unfollowUserId}) {
    //Remove unfollowUser from user's userFollowing.
    _firebaseFirestore
        .collection(Paths.following)
        .doc(userId)
        .collection(Paths.userFollowing)
        .doc(unfollowUserId)
        .delete();

    //Remove user from unfollowUser's userFollowers.
    _firebaseFirestore
        .collection(Paths.followers)
        .doc(unfollowUserId)
        .collection(Paths.userFollowers)
        .doc(userId)
        .delete();
  }
}
