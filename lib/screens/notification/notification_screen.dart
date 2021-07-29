import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/components/text/centered_text.dart';
import 'bloc/notifications_bloc.dart';
import 'widgets/notification_tile.dart';
import 'dart:developer' as developer;

class NotificationScreen extends StatelessWidget {
  static const String routeName = '/notifications';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
          switch (state.status) {
            case NotificationStatus.error:
              return CenteredText(text: state.failure.message);
            case NotificationStatus.loaded:
              return ListView.builder(
                  itemCount: state.notifications.length,
                  itemBuilder: (BuildContext context, int index) {
                    final notification = state.notifications[index];
                    return NotificationTile(notification: notification!);
                  });
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}
