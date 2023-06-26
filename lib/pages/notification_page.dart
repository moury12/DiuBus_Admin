import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:transpor_guidance_admin/models/admin_model.dart';

import '../Authservice/authservice.dart';
import '../providers/admin_provider.dart';

class NotificationPage extends StatefulWidget {
  static const String routeName = '/notification';
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String? mtoken = "";
  late AdminProvider adminProvider;
  @override
  void initState() {
    requestPermission();
    getToken();
    initInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final adminProvider = Provider.of<AdminProvider>(context);

    return Scaffold(
      appBar: AppBar(title:
      Row(
        children: [
          Image.asset('assets/logo2.png',height: 70,width: 70,),
          Center(child: Text('Notifications ',style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold,fontSize: 15))),
        ],
      ),




        backgroundColor: Colors.white,elevation: 0,),
      body:
      Card(

      ),
    );
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        sound: true,
        provisional: false);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined');
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print('My token $mtoken');
      });
      saveToken(token);
    });
  }

  void saveToken(String? token) async {
    await FirebaseFirestore.instance
        .collection(collectionAdmin)
        .doc(AuthService.currentUser!.uid)
        .update({adminFieldtoken: token});
  }

  void initInfo() async {
    var androidInitialize = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(android: androidInitialize);
    FlutterLocalNotificationsPlugin().initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        try {
          var payload = response.payload;

          if(payload != null && payload.isNotEmpty) {
          } else {}
          print('Received notification - Payload: $payload');
        } catch (e) {
          print('Error handling received notification: $e');
        }
        return;
      },
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{

        print('${message.notification?.title}/n${message.notification?.body}');
        BigTextStyleInformation bigTextStyleInformation= BigTextStyleInformation(message.notification!.body.toString(),htmlFormatContentTitle: true,);
        AndroidNotificationDetails androidNotificationDetails =AndroidNotificationDetails(
            'DiuBus', 'Admin panel', importance: Importance.high, styleInformation: bigTextStyleInformation, priority: Priority.high, playSound: true
        );
        NotificationDetails notificationDetails =NotificationDetails(
            android: androidNotificationDetails
        );
        await FlutterLocalNotificationsPlugin().show(0, message.notification?.title, message.notification?.body, notificationDetails, payload: message.data['title']
        );
    });
  }

}
