import 'package:flutter/material.dart';
import 'package:flutter_sample/screens/profile/widgets/widgets.dart';

class ProfileStats extends StatelessWidget {
  final bool isCurrentUser;
  final bool isFollowing;
  final int posts;
  final int followers;
  final int following;

  const ProfileStats({
    Key key,
    this.isCurrentUser,
    this.isFollowing,
    this.posts,
    this.followers,
    this.following,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _Stats(
                count: posts,
                label: 'posts',
              ),
              _Stats(
                count: followers,
                label: 'followers',
              ),
              _Stats(
                count: following,
                label: 'following',
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ProfileButton(
              isCurrentUser: isCurrentUser,
              isFollowing: isFollowing,
            ),
          ),
        ],
      ),
    );
  }
}

class _Stats extends StatelessWidget {
  final int count;
  final String label;

  const _Stats({Key key, @required this.count, @required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black54,
            ),
          )
        ],
      ),
    );
  }
}
