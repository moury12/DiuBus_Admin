import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  static const String routeName = '/notification';
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
    );
  }
}
