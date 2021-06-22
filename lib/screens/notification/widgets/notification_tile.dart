import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/core/components/image/user_profile_image.dart';
import 'package:flutter_sample/core/constant/enums/notification_type_enum.dart';
import 'package:flutter_sample/models/models.dart';
import 'package:flutter_sample/screens/screens.dart';
import 'package:intl/intl.dart';

class NotificationTile extends StatelessWidget {
  final Notif notification;

  const NotificationTile({
    Key key,
    @required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: UserProfileImage(
        radius: 18.0,
        profileImageUrl: notification.fromUser.profileImageUrl,
      ),
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: notification.fromUser.username,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const TextSpan(text: ' '),
            TextSpan(text: _getText(notification)),
          ],
        ),
      ),
      subtitle: Text(
        DateFormat.yMd().add_jm().format(notification.date),
        style: TextStyle(
          color: Colors.grey[600],
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: _getTrailing(context, notification),
      onTap: () => Navigator.of(context).pushNamed(
        ProfileScreen.routeName,
        arguments: ProfileScreenArgs(userId: notification.fromUser.id),
      ),
    );
  }

  String _getText(Notif notification) {
    switch (notification.type) {
      case NotificationType.like:
        return 'liked your post.';
      case NotificationType.comment:
        return 'commented on your post.';
      case NotificationType.follow:
        return 'followed you.';
      default:
        return '';
    }
  }

  Widget _getTrailing(BuildContext context, Notif notif) {
    if (notification.type == NotificationType.like ||
        notification.type == NotificationType.comment) {
      return GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(
          CommentsScreen.routeName,
          arguments: CommentsScreenArgs(post: notification.post),
        ),
        child: CachedNetworkImage(
          height: 60.0,
          width: 60.0,
          imageUrl: notification.post.imageUrl,
          fit: BoxFit.cover,
        ),
      );
    } else if (notification.type == NotificationType.follow) {
      return const SizedBox(
        height: 60.0,
        width: 60.0,
        child: Icon(Icons.person_add),
      );
    }
    return const SizedBox.shrink();
  }
}
