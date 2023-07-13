
import 'package:transpor_guidance_admin/models/userModel.dart';

const String collectionComment = 'Feedback';
const String commentFieldId = 'feedbackId';
const String commentFieldUserModel = 'userModel';

const String commentFieldComment = 'comment';
const String commentFieldDate = 'date';
const String commentFieldApproved = 'approved';

class FeedbackModel {
  String commentId;
  UserModel userModel;
  String comment;
  String date;

  bool approved;

  FeedbackModel({
    required this.commentId,
    required this.userModel,

    required this.comment,
    required this.date,
    this.approved = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      commentFieldId: commentId,
      commentFieldUserModel: userModel.toMap(),

      commentFieldComment: comment,
      commentFieldDate: date,
      commentFieldApproved: approved
    };
  }

  factory FeedbackModel.fromMap(Map<String, dynamic> map) => FeedbackModel(
      commentId: map[commentFieldId],
      userModel: UserModel.fromMap(map[commentFieldUserModel]),

      comment: map[commentFieldComment],
      date: map[commentFieldDate],
      approved: map[commentFieldApproved]);
}
