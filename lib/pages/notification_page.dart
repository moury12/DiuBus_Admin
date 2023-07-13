import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:transpor_guidance_admin/models/admin_model.dart';
import 'package:transpor_guidance_admin/models/notification_model_user.dart';
import 'package:transpor_guidance_admin/models/reqModel.dart';
import 'package:transpor_guidance_admin/pages/home_page.dart';
import 'package:transpor_guidance_admin/pages/schedule_page.dart';
import 'package:transpor_guidance_admin/providers/bus_provider.dart';

import '../Authservice/authservice.dart';
import '../models/bus_model.dart';
import '../models/driver_model.dart';
import '../models/notification_model.dart';
import '../models/schedule_model.dart';
import '../providers/admin_provider.dart';
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
      appBar: AppBar(title:
      Row(
        children: [
          Image.asset('assets/logo2.png',height: 70,width: 70,),
          Center(child: Text('Notifications ',style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold,fontSize: 15))),
        ],
      ),
        backgroundColor: Colors.white,elevation: 0,),
      body: Consumer<BusProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.notificationList.length,
          itemBuilder: (context, index) {
            final notification =provider.notificationList[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: ListTile(
                  leading: Icon(Icons.notifications_none),
                  tileColor: notification.status? null :Colors.deepPurple.shade100,
                  onTap: (){
                    _navigate(context,notification,provider);
                  },
                  title:Text(notification.type) ,
                  subtitle:Text(notification.message) ,

                ),
              ),
            );
          },
        ),
      ),

    );
  }
  void _navigate(BuildContext context, NotificationModel notification, BusProvider provider) {
    String routeName='';
    dynamic id='';
    switch(notification.type){


      case NotificationType.feedback:

        id= notification.feedbackModel!.userModel;
        break;
      case NotificationType.request:
        id = notification.reqModel;
        _showCustomDialog(context,id,notification);

        break;

    }
    provider.updateNotificationStatus(notification.id, notification.status);
    Navigator.pushNamed(context, routeName, arguments: id);

  }
void _showCustomDialog(BuildContext context,RequestModel id,NotificationModel notificationModel) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return  AlertDialog(
        title: Column(
          children: [
            Text(id.startTime),
            Image.asset('assets/logo2.png',height: 70,width: 70,),
            Text('Providing a bus for ${id.from}<>${id.destination} this route',style: TextStyle(fontSize: 12),),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
        Consumer<BusProvider>(
        builder: (context, provider, child) => Padding(
      padding: const EdgeInsets.all(8.0),
      child:DropdownButtonFormField<BusModel>(
        hint: const Text('Select Bus',style: TextStyle(fontSize: 12),),
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
              value: busModel, child: Text(busModel.busName,style: TextStyle(fontSize: 12),)))
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
      hint: const Text('Assign driver',style: TextStyle(fontSize: 12),),
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
      value: driverModel, child: Text(driverModel.name,style: TextStyle(fontSize: 12),)))
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
          FloatingActionButton.small(backgroundColor: Colors.redAccent.shade100,
            onPressed: () {
              savetoSchedule(id);
              busprovider.deleteNotificationById(notificationModel.id);
            } ,
            child: Icon(Icons.check),
          ),  FloatingActionButton.small(backgroundColor: Colors.blueAccent.shade100,
            onPressed: () {
              busprovider.deleteNotificationById(notificationModel.id);
              busprovider.deleteRequestById(id.reqId);
            },
            child: Icon(Icons.cancel_outlined),
          ),
        ],
      );
    },
  );
}

  void savetoSchedule(RequestModel id) async{
    if (busModel == null) {
      showMsg(context, 'Field required');
      return;
    }   if (driverModel == null) {
      showMsg(context, 'Field required');
      return;
    }
    EasyLoading.show(status: 'Please wait');
    final schedule = ScheduleModel(
        busModel: busModel!,driverModel: driverModel,
        startTime: id.startTime,
        departureTime:'',
        from: id.from,
        destination: id.destination);
    try {
      await busprovider.addSchedule(schedule);
      EasyLoading.dismiss();

      if (mounted) {
        showMsg(context, "set Schedule");
        final notificationModel=NotificationUSerModel( date: getFormattedDate(DateTime.now(),pattern: 'dd/MM/yyyy'), type: NotificationuserType.request, message: 'We Provide a bus for ${id.from}<>${id.destination} this route at ${id.startTime} it will arrive your route as soon as possible');
        busprovider.addNotification(notificationModel);
        Navigator.pop(context);

      }
    } catch (error) {
      EasyLoading.dismiss();
      rethrow;
    }
  }
}
