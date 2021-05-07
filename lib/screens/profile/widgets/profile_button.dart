import 'package:flutter/material.dart';
import 'package:flutter_sample/screens/screens.dart';

class ProfileButton extends StatelessWidget {
  final bool isCurrentUser;
  final bool isFollowing;

  const ProfileButton({
    Key key,
    @required this.isCurrentUser,
    @required this.isFollowing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isCurrentUser
        ? ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed(
              EditProfileScreen.routeName,
              arguments: EditProfileScreenArgs(context: context),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.orange.shade50,
              onSurface: Colors.amber.shade50,
              onPrimary: Colors.black,
            ),
            child: const Text(
              'Edit Profile',
              style: TextStyle(fontSize: 16.0),
            ),
          )
        : ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary:
                  isFollowing ? Colors.grey.shade300 : Colors.blue.shade400,
              onSurface: Colors.amber.shade50,
              onPrimary: Colors.red.shade400,
            ),
            child: Text(
              isFollowing ? 'Unfollow' : 'Follow',
              style: TextStyle(fontSize: 16.0),
            ),
          );
  }
}
