part of 'notifications_bloc.dart';

enum NotificationStatus { initial, loading, loaded, error }

class NotificationsState extends Equatable {
  final List<Notif> notifications;
  final NotificationStatus status;
  final Failure failure;

  const NotificationsState({
    @required this.notifications,
    @required this.status,
    @required this.failure,
  });

  factory NotificationsState.initial() {
    return const NotificationsState(
      notifications: [],
      status: NotificationStatus.initial,
      failure: Failure(),
    );
  }

  @override
  List<Object> get props => [notifications, status, failure];

  NotificationsState copyWith({
    List<Notif> notifications,
    NotificationStatus status,
    Failure failure,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
