const String collectionAdmin = 'Admins';
const String adminFieldId = 'adminID';
const String adminFieldName = 'Name';
const String adminFieldEmail = 'Email';
const String adminFieldPhone = 'phone';
const String adminFieldDesignation = 'Designation';
const String adminFieldisAdmin = 'isAdmin';
const String adminFieldimageURl = 'imageURl';
//const String driverFieldimageURl = 'driver image';
//const String driverFieldage = 'age';
const String adminFieldtoken = 'admin token';
class AdminModel {
  String adminId;
  String name;
  String email;
  String phone;
  String? imageUrl;
  // num? age;
 // String? driverImage;
String? adminToken;
  String? designation;
  bool isAdmin;


  AdminModel(
      {required this.adminId,
      required this.name,
      required this.email,
      required this.phone,
       this.designation,
        this.imageUrl,
        // this.age,
       // this.driverImage,
      this.adminToken,
      required this.isAdmin,
     });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      adminFieldId: adminId,
      adminFieldName: name,
      adminFieldEmail: email,
      adminFieldPhone: phone,  adminFieldtoken: adminToken,
      //driverFieldage:age ,
     // driverFieldimageURl:driverImage,
      adminFieldimageURl: imageUrl,
      adminFieldDesignation: designation,
      adminFieldisAdmin: isAdmin,

    };
  }

  factory AdminModel.fromMap(Map<String, dynamic> map) => AdminModel(
      adminId: map[adminFieldId],
      name: map[adminFieldName],
    imageUrl: map[adminFieldimageURl],
      //age: map[driverFieldage],
     adminToken: map[adminFieldtoken],

     // driverImage: map[driverFieldimageURl],
      email: map[adminFieldEmail],
      phone: map[adminFieldPhone],
      designation: map[adminFieldDesignation],
      isAdmin: map[adminFieldisAdmin],
      );
}
