import 'package:flutter/material.dart';
import '../../core/init/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatelessWidget {
  static const String routeName = '/feed';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Icon(Icons.near_me),
          onLongPress: () {
            context.read<ThemeNotifier>().changeTheme();
          },
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => Scaffold(
                appBar: AppBar(
                  title: Text('Hello'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
