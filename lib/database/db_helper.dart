import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transpor_guidance_admin/models/admin_model.dart';
import 'package:transpor_guidance_admin/models/bus_model.dart';
import 'package:transpor_guidance_admin/models/driver_model.dart';
import 'package:transpor_guidance_admin/models/feedback_model.dart';
import 'package:transpor_guidance_admin/models/notice_model.dart';
import 'package:transpor_guidance_admin/models/notification_model_user.dart';
import 'package:transpor_guidance_admin/models/reqModel.dart';
import 'package:transpor_guidance_admin/models/schedule_model.dart';
import 'package:transpor_guidance_admin/models/userModel.dart';

import '../models/notification_model.dart';

class dbHelper{
  static final db =FirebaseFirestore.instance;
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getAdminInfo(
      String uid) =>
      db.collection(collectionAdmin).doc(uid).snapshots();

static Future<DocumentSnapshot<Map<String, dynamic>>> getreqById(String id) =>
db.collection(collectionRequest).doc(id).get();
static Future<void> deletenotificationById(String id) =>
db.collection(collectionNotification).doc(id).delete();
static Future<void> deleteScheduleByid(String id) =>
db.collection(collectionSchedule).doc(id).delete();

  static Future<void> addAdmin(AdminModel adminModel) {
    return db.collection(collectionAdmin).doc(adminModel.adminId).set(adminModel.toMap());
  }
  static Future<void> updateAdminField(String uid, Map<String, dynamic> map) {
    return db.collection(collectionUser).doc(uid).update(map);
  }

  static Future<void> registerDrivers(DriverModel driverModel) {
    return db.collection(collectiondriver).doc(driverModel.driverId).set(driverModel.toMap());
  }

  static Future<void> addBus(BusModel busModel) {
    return db.collection(collectionBus).doc(busModel.busId).set(busModel.toMap());
  }
  static Stream<QuerySnapshot<Map<String,dynamic>>>getAllBus()=>
      db.collection(collectionBus).snapshots();

  static Future<void> addSchedule(ScheduleModel schedule) {
    return db.collection(collectionSchedule).doc(schedule.id).set(schedule.toMap());

  }
  static Stream<QuerySnapshot<Map<String,dynamic>>>getAllSchedule()=>
      db.collection(collectionSchedule).snapshots();
  static Stream<QuerySnapshot<Map<String,dynamic>>>getAllFeedback()=>
      db.collection(collectionComment).snapshots();
  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllDriver() =>
      db.collection(collectiondriver).snapshots();

  static Stream<QuerySnapshot<Map<String,dynamic>>> getUserInfo() =>
      db.collection(collectionUser).snapshots();
  static Stream<QuerySnapshot<Map<String,dynamic>>>getAllNotification()=>
      db.collection(collectionNotification).snapshots();

  static Future <void> updateNotificationStatus(String notId, bool status) {
    return db.collection(collectionNotification).doc(notId).update({notificationFieldStatus: status});
  }
  static Future<void> adduserNotification(NotificationUSerModel notificationModel) {
    return db.collection(collectionNotificationUser).doc(notificationModel.id).set(notificationModel.toMap());
  }

  static Future<void> deleteRequestById(String? reqId) =>db.collection(collectionNotification).doc(reqId).delete();

  static Future<void> addNotice(NoticeModel notice) {
    return db.collection(collectionNotice).doc(notice.noticeId).set(notice.toMap());

  }
  static Stream<QuerySnapshot<Map<String,dynamic>>>getAllNotice()=>
      db.collection(collectionNotice).snapshots();

}