
import 'package:flutter_sample/models/models.dart';

abstract class BaseNotificationRepository{
  Stream<List<Future<Notif?>>> getUserNotifications({required String userId});
}