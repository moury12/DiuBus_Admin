import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transpor_guidance_admin/pages/add_bus_info.dart';
import 'package:transpor_guidance_admin/pages/notification_page.dart';
import 'package:transpor_guidance_admin/providers/bus_provider.dart';
import 'package:transpor_guidance_admin/providers/driver_provider.dart';
import 'package:transpor_guidance_admin/providers/userProvider.dart';

import '../utils/notification_service.dart';
import 'home_page.dart';

class DashboardPage extends StatefulWidget {
  static const String routeName = '/dash';
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //print('Got a message whilst in the foreground!');
      //print('Message data: ${message.data}');

      if (message.notification != null) {
        //print('Message also contained a notification: ${message.notification}');
        NotificationService service = NotificationService();
        service.sendNotifications(message);
      }
    });
    NotificationService service = NotificationService();
    setupInteractedMessage();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<BusProvider>(context, listen: false).getAllBus();
    Provider.of<BusProvider>(context, listen: false).getAllSchedule();
    Provider.of<DriverProvider>(context, listen: false).getAllDriver();
    Provider.of<UserProvider>(context, listen: false).getUserInfo();
    Provider.of<BusProvider>(context, listen: false).getAllNotification();
    Provider.of<BusProvider>(context, listen: false).getAllFeedback();
    Provider.of<BusProvider>(context, listen: false).getAllNotice();
    super.didChangeDependencies();
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          Icon(
            Icons.home,
            size: 25,
            color: Colors.white,
          ),
          Icon(
            Icons.add_circle,
            size: 25,
            color: Colors.white,
          ),
          Icon(
            Icons.notifications,
            size: 25,
            color: Colors.white,
          )
        ],
        color: Colors.blue.shade200,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.red.shade200,
        index: index,
        height: 60,
        onTap: (selectedIndex) {
          setState(() {
            index = selectedIndex;
          });
        },
      ),
      body: getSelectedPage(index: index),
    );
  }

  Widget getSelectedPage({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = HomePage();
        break;
      case 1:
        widget = AddBusPage();
        break;
      case 2:
        widget = NotificationPage();
        break;
      default:
        widget = HomePage();
        break;
    }
    return widget;
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['key'] == 'feed') {
      print('REDIRECTING...');
      //final code = message.data['value'];
      /*//final productModel = Provider.of<ProductProvider>(context, listen: false)
      .getProductByIdFromCache(id);*/
      Navigator.pushNamed(context, NotificationPage.routeName);
    } else if (message.data['key'] == 'request') {
      Navigator.pushNamed(context, NotificationPage.routeName);
      final id = message.data['value'];
      Provider.of<BusProvider>(context, listen: false).getProductById(id).then(
          (value) => Navigator.pushNamed(context, NotificationPage.routeName,
              arguments: value));
    }
  }
}
