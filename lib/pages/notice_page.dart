import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:transpor_guidance_admin/models/notice_model.dart';
import 'package:transpor_guidance_admin/pages/dashboard_page.dart';
import 'package:transpor_guidance_admin/providers/bus_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/notification_model_user.dart';
import '../utils/constants.dart';

class NoticePage extends StatefulWidget {
  static const String routeName = '/notice';
  const NoticePage({Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  late BusProvider busProvider;
  @override
  void didChangeDependencies() {
    busProvider = Provider.of<BusProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  final titleController = TextEditingController();
  final msgController = TextEditingController();
  String? busImage;
  @override
  void dispose() {
    titleController.dispose();
    msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo2.png',
              height: 70,
              width: 70,
            ),
            Center(
                child: Text('Notice',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 15))),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black54,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Heading..',
                icon: Icon(
                  Icons.wysiwyg_rounded,
                  color: Colors.blueAccent.shade100,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: msgController,
              decoration: InputDecoration(
                hintText: 'Description..', border: OutlineInputBorder(),
                //icon: Icon(Icons.mark_as_unread,color: Colors.redAccent.shade100,),
              ),
              maxLines: 7,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton.small(
                heroTag: 1,
                onPressed: () {
                  _getBusImage(ImageSource.gallery);
                },
                backgroundColor: Colors.redAccent.shade100,
                child: Icon(Icons.image_outlined, color: Colors.white),
              ),
              FloatingActionButton.small(
                heroTag: 2,
                onPressed: () {},
                backgroundColor: Colors.redAccent.shade100,
                child: Icon(Icons.file_present, color: Colors.white),
              ),
              FloatingActionButton.small(
                heroTag: 3,
                onPressed: _save,
                backgroundColor: Colors.redAccent.shade100,
                child: Icon(Icons.send, color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _getBusImage(ImageSource gallery) async {
    final pickedImage =
        await ImagePicker().pickImage(source: gallery, imageQuality: 70);
    if (pickedImage != null) {
      setState(() {
        busImage = pickedImage.path;
      });
    }
  }

  void _save() async {
    if (titleController.text.isEmpty) {
      showMsg(context, 'Field Required');
      return;
    }
    if (msgController.text.isEmpty) {
      showMsg(context, 'Field Required');
      return;
    }
    EasyLoading.show(status: 'Please wait');
    final downloadurl = await busProvider.uploadImage(busImage);
    final notice = NoticeModel(
        Noticetitle: titleController.text,
        message: msgController.text,
        date: getFormattedDate(DateTime.now(), pattern: 'dd/MM/yyyy'),
        image: downloadurl,
        noticeId: DateTime.now().millisecondsSinceEpoch.toString());
    try {
      busProvider.addNotice(notice);
      EasyLoading.dismiss();
      showMsg(context, "Notice Posted");
      final notificationModel = NotificationUSerModel(
          date: getFormattedDate(DateTime.now(), pattern: 'dd/MM/yyyy'),
          type: NotificationuserType.Notice,
          message: 'A notice has been posted "${notice.Noticetitle}"');
      busProvider.addNotification(notificationModel);
      clear();
      _notifyUser(notice);
      Navigator.pushReplacementNamed(context, DashboardPage.routeName);
    } catch (e) {}
  }

  void _notifyUser(NoticeModel notice) async {
    final url = 'https://fcm.googleapis.com/fcm/send';
    final header = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };
    final body = {
      "to": "/topics/noticed",
      "notification": {
        "title": "A notice has been posted ",
        "body": "${notice.Noticetitle}"
      },
      "data": {"key": "not", "value": notice.noticeId}
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

  void clear() {
    titleController.clear();
    msgController.clear();
  }
}
