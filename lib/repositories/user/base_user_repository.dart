import '../../models/user_model.dart';

abstract class BaseUserRepository {
  Future<User> getUserWithId({String userId});
  Future<void> updateUser({User user});
  Future<void> searchUsers({String query});
  void followUser({String userId, String followUserId});
  void unfollowUser({String userId, String unfollowUserId});
  Future<bool> isFollowing({String userId,String otherUserId});
}
