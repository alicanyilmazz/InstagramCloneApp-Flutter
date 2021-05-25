import '../../models/user_model.dart';

abstract class BaseUserRepository {
  Future<User> getUserWithId({String userId});
  Future<void> updateUser({User user});
  Future<void> searchUsers({String query});
}
