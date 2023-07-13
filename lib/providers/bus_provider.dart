import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:transpor_guidance_admin/database/db_helper.dart';
import 'package:transpor_guidance_admin/models/bus_model.dart';
import 'package:transpor_guidance_admin/models/feedback_model.dart';
import 'package:transpor_guidance_admin/models/notification_model_user.dart';
import 'package:transpor_guidance_admin/models/schedule_model.dart';

import '../models/notification_model.dart';
import '../models/reqModel.dart';

class BusProvider extends ChangeNotifier{
  List<BusModel> busList=[];
  List<ScheduleModel>scheduleList=[];
  List<FeedbackModel>feedlist=[];
  List <NotificationModel>  notificationList =[];
  Future<RequestModel> getProductById(String id) async {
    final snapshot = await dbHelper.getreqById(id);
    return RequestModel.fromMap(snapshot.data()!);
  }
  getAllNotification(){
    dbHelper.getAllNotification().listen((snapshot) {
      notificationList=List.generate(snapshot.docs.length, (index) => NotificationModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }
  Future<void> updateNotificationStatus(String notId, bool status)async {
    dbHelper.updateNotificationStatus(notId,status);
  }
  Future<void> addBus(BusModel busModel) {
    return dbHelper.addBus(busModel);
  }
  Future<String> uploadImage(String? thumbnailImageLocalPath)async {
    final photoRef= FirebaseStorage.instance.ref().child('Images/${DateTime.now().microsecondsSinceEpoch}');
    final uploadTask=photoRef.putFile(File(thumbnailImageLocalPath!));
    final snapshot= await uploadTask.whenComplete(() => const Text('Upload Sucessfully'));
    return snapshot.ref.getDownloadURL();
  }
  getAllBus(){
    dbHelper.getAllBus().listen((snapshot) {
      busList=List.generate(snapshot.docs.length, (index) => BusModel.fromMap(snapshot.docs[index].data()));
      busList.sort((cat1, cat2)=>cat1.busName.compareTo(cat2.busName));
      notifyListeners();
    });
  }
  getAllSchedule(){
    dbHelper.getAllSchedule().listen((snapshot) {
      scheduleList=List.generate(snapshot.docs.length, (index) => ScheduleModel.fromMap(snapshot.docs[index].data()));

      notifyListeners();
    });
  }
  getAllFeedback(){
    dbHelper.getAllFeedback().listen((snapshot) {
      feedlist=List.generate(snapshot.docs.length, (index) => FeedbackModel.fromMap(snapshot.docs[index].data()));

      notifyListeners();
    });
  }
  Future<void> addSchedule(ScheduleModel schedule) {
    return dbHelper.addSchedule(schedule);
  }
  Future<void> addNotification(NotificationUSerModel notificationModel) {
    return dbHelper.adduserNotification(notificationModel);
  }
  Future<void> deleteNotificationById(String id) async {
    await dbHelper.deletenotificationById(id);

  }

  void deleteRequestById(String? reqId) async{
    await dbHelper.deleteRequestById(reqId);
  }
  //Future<void> deleteReq(RequestModel id) {}
}