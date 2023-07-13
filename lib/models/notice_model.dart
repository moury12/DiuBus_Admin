
const String collectionNotice = 'Notice';
const String noticeFieldtitle = 'Noticetitle';
const String noticeFieldide = 'id';
const String noticeFieldmsg = 'message';
const String noticeFielddate = 'date';
const String noticeFieldimg = 'image';
const String noticeFieldfile = 'file';

class NoticeModel{
  String? noticeId;
  String Noticetitle;
  String message;
  String date;
  String? image;
  String? file;



  NoticeModel(
      {
        this.noticeId,
        required this.Noticetitle,

        required  this.message,
        required  this.date,
        this.image,
         this.file,
       });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      noticeFieldide:noticeId,
      noticeFieldtitle: Noticetitle,

      noticeFieldmsg: message,
      noticeFielddate: date,
      noticeFieldimg: image,
      noticeFieldfile: file,

    };
  }

  factory NoticeModel.fromMap(Map<String, dynamic> map) => NoticeModel(
    Noticetitle: map[noticeFieldtitle],
    noticeId: map[noticeFieldide],
    message: map[noticeFieldmsg],
    date: map[noticeFielddate],
    image: map[noticeFieldimg],
    file: map[noticeFieldfile]
  );}
