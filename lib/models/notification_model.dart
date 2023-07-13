



import 'package:transpor_guidance_admin/models/reqModel.dart';
import 'package:transpor_guidance_admin/models/userModel.dart';

import 'feedback_model.dart';

const String collectionNotification = 'Notifications';

const String notificationFieldId = 'notificationId';
const String notificationFieldType = 'type';
const String notificationFieldMessage = 'Message';
const String notificationFieldStatus = 'status';
const String notificationFieldDate = 'Date';
const String notificationFieldComment = 'feedback';
const String notificationFieldUser = 'user';
const String notificationFieldOrder = 'request';

class NotificationModel {
  String id;
  String type;
  String message;
  bool status;
  FeedbackModel? feedbackModel;
  UserModel? userModel;
  RequestModel? reqModel;
  String? date;


  NotificationModel(
      {required this.id,
        required this.type,
        required this.message,
        required this.status,
      this.feedbackModel,
      this.userModel,
      this.reqModel,
      this.date});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      notificationFieldId: id,
      notificationFieldType: type,
      notificationFieldMessage: message,
      notificationFieldStatus: status,
      notificationFieldDate: date,
      notificationFieldComment: feedbackModel?.toMap(),
      notificationFieldUser: userModel?.toMap(),
      notificationFieldOrder: reqModel?.toMap(),
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) =>
      NotificationModel(
        id: map[notificationFieldId],
        type: map[notificationFieldType],
        message: map[notificationFieldMessage],
        status: map[notificationFieldStatus],
        date: map[notificationFieldDate],
        feedbackModel: map[notificationFieldComment] == null
            ? null
            : FeedbackModel.fromMap(map[notificationFieldComment]),
        userModel: map[notificationFieldUser] == null
            ? null
            : UserModel.fromMap(map[notificationFieldUser]),
        reqModel: map[notificationFieldOrder] == null
            ? null
            : RequestModel.fromMap(map[notificationFieldOrder]),
      );
}
