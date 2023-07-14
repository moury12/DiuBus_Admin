import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:transpor_guidance_admin/models/notification_model_user.dart';
import 'package:transpor_guidance_admin/models/reqModel.dart';
import 'package:transpor_guidance_admin/pages/home_page.dart';
import 'package:transpor_guidance_admin/providers/bus_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/bus_model.dart';
import '../models/driver_model.dart';
import '../models/notification_model.dart';
import '../models/schedule_model.dart';
import '../providers/driver_provider.dart';
import '../utils/constants.dart';

class NotificationPage extends StatefulWidget {
  static const String routeName = '/notification';
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late RequestModel requestModel;
  BusModel? busModel;
  DriverModel? driverModel;
  late BusProvider busprovider;
  @override
  void didChangeDependencies() {
    busprovider = Provider.of<BusProvider>(context, listen: false);
    // requestModel = ModalRoute.of(context)!.settings.arguments as RequestModel;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //final adminProvider = Provider.of<AdminProvider>(context);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black54,
        title: Row(
          children: [
            Image.asset(
              'assets/logo2.png',
              height: 70,
              width: 70,
            ),
            Center(
                child: Text('Notifications ',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 15))),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<BusProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.notificationList.length,
          itemBuilder: (context, index) {
            final notification = provider.notificationList[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: ListTile(
                  leading: notification.type=='New Feedback'?Image.asset('assets/i2.png',height: 40,width: 50,):Image.asset('assets/i5.png',height: 40,width: 50,),
                  tileColor:
                      notification.status ? null : Colors.white,
                  onTap: () {
                    _navigate(context, notification, provider);
                  },
                  title: Text(notification.type,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                  subtitle: Column(
                    children: [
                      Text(notification.message,style: TextStyle(color: Colors.black54,fontSize: 10),),
                      Text(notification.date??'',style: TextStyle(color: Colors.blue,fontSize: 10),),

                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _navigate(BuildContext context, NotificationModel notification,
      BusProvider provider) {
    String routeName = '';
    dynamic id = '';
    switch (notification.type) {
      case NotificationType.feedback:
        id = notification.feedbackModel!.commentId;
        routeName=HomePage.routeName;
        break;
      case NotificationType.request:
        id = notification.reqModel;
        _showCustomDialog(context, id, notification);

        break;
    }
    provider.updateNotificationStatus(notification.id, notification.status);
    Navigator.pushNamed(context, routeName, arguments: id);
  }

  void _showCustomDialog(BuildContext context, RequestModel id,
      NotificationModel notificationModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Text(id.startTime),
              Image.asset(
                'assets/logo2.png',
                height: 70,
                width: 70,
              ),
              Text(
                'Providing a bus for ${id.from}<>${id.destination} this route',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer<BusProvider>(
                builder: (context, provider, child) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<BusModel>(
                      hint: const Text(
                        'Select Bus',
                        style: TextStyle(fontSize: 12),
                      ),
                      value: busModel,
                      isExpanded: true,
                      validator: (value) {
                        if (value == null) {
                          return 'please select a Bus';
                        }
                        return null;
                      },
                      items: provider.busList
                          .map((busModel) => DropdownMenuItem(
                              value: busModel,
                              child: Text(
                                busModel.busName,
                                style: TextStyle(fontSize: 12),
                              )))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          busModel = value;
                        });
                      }),
                ),
              ),
              Consumer<DriverProvider>(
                builder: (context, provider, child) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<DriverModel>(
                      hint: const Text(
                        'Assign driver',
                        style: TextStyle(fontSize: 12),
                      ),
                      value: driverModel,
                      isExpanded: true,
                      validator: (value) {
                        if (value == null) {
                          return 'please select a driver';
                        }
                        return null;
                      },
                      items: provider.driverList
                          .map((driverModel) => DropdownMenuItem(
                              value: driverModel,
                              child: Text(
                                driverModel.name,
                                style: TextStyle(fontSize: 12),
                              )))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          driverModel = value;
                        });
                      }),
                ),
              ),
            ],
          ),
          actions: [
            FloatingActionButton.small(
              backgroundColor: Colors.redAccent.shade100,
              onPressed: () {
                savetoSchedule(id);
                busprovider.deleteNotificationById(notificationModel.id);

              },
              child: Icon(Icons.check),
            ),
            FloatingActionButton.small(
              backgroundColor: Colors.blueAccent.shade100,
              onPressed: () {
                _notifyUserdeny(id);
                busprovider.deleteNotificationById(notificationModel.id);
                final notificationuserModel = NotificationUSerModel(
                    date: getFormattedDate(DateTime.now(), pattern: 'dd/MM/yyyy'),
                    type: NotificationuserType.deny,
                    message: 'We are extremely sorry!! There are currently no buses available on this  ${id.from}<>${id.destination}  route at ${id.startTime} ');
                busprovider.addNotification(notificationuserModel);
                Navigator.pop(context);
                //busprovider.deleteRequestById(id.reqId);
              },
              child: Icon(Icons.cancel_outlined),
            ),
          ],
        );
      },
    );
  }

  void savetoSchedule(RequestModel id) async {
    if (busModel == null) {
      showMsg(context, 'Field required');
      return;
    }
    if (driverModel == null) {
      showMsg(context, 'Field required');
      return;
    }
    EasyLoading.show(status: 'Please wait');
    final schedule = ScheduleModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        busModel: busModel!,
        driverModel: driverModel,
        startTime: id.startTime,
        departureTime: '',
        from: id.from,
        destination: id.destination);
    try {
      await busprovider.addSchedule(schedule);
      EasyLoading.dismiss();

      if (mounted) {
        showMsg(context, "set Schedule");
        final notificationModel = NotificationUSerModel(
            date: getFormattedDate(DateTime.now(), pattern: 'dd/MM/yyyy'),
            type: NotificationuserType.request,
            message: 'We Provide a bus for ${id.from}<>${id.destination} this route at ${id.startTime} it will arrive your route as soon as possible');
        busprovider.addNotification(notificationModel);
        _notifyUser(id, schedule.id);
        Navigator.pop(context);
      }
    } catch (error) {
      EasyLoading.dismiss();
      rethrow;
    }
  }

  void _notifyUser(RequestModel requestBus, String? id) async {
    final url = 'https://fcm.googleapis.com/fcm/send';
    final header = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };
    final body = {
      "to": "/topics/accept",
      "notification": {
        "title": "A New Schedule assigned for ${requestBus.startTime} ",
        "body":
            "Please wait for  bus on this ${requestBus.from}<>${requestBus.destination} route."
      },
      "data": {"key": "reqaccept", "value": requestBus.reqId}
    };
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: header,
        body: json.encode(body),
      );
    } catch (error) {
      print(error.toString());
    }
  }

  void _notifyUserdeny(RequestModel requestBus) async {
    final url = 'https://fcm.googleapis.com/fcm/send';
    final header = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };
    final body = {
      "to": "/topics/deny",
      "notification": {
        "title": "Denying Bus request",
        "body":
            "we are Very sorry! There are currently no buses available on this ${requestBus.from}<>${requestBus.destination} route."
      },
      "data": {"key": "reqdeny", "value": requestBus.reqId}
    };
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: header,
        body: json.encode(body),
      );
    } catch (error) {
      print(error.toString());
    }
  }
}
