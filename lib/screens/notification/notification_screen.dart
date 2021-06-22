import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample/core/components/text/centered_text.dart';
import 'package:flutter_sample/screens/notification/bloc/notifications_bloc.dart';
import 'package:flutter_sample/screens/notification/widgets/notification_tile.dart';
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
              break;
            case NotificationStatus.loaded:
              return ListView.builder(
                  itemCount: state.notifications.length,
                  itemBuilder: (BuildContext context, int index) {
                    final notification = state.notifications[index];
                    return NotificationTile(notification: notification);
                  });
              break;
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
