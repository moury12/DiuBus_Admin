const String collectionAdmin = 'Admins';
const String adminFieldId = 'adminID';
const String adminFieldName = 'Name';
const String adminFieldEmail = 'Email';
const String adminFieldPhone = 'phone';
const String adminFieldDesignation = 'Designation';
const String adminFieldisAdmin = 'isAdmin';
const String adminFieldimageURl = 'imageURl';
class AdminModel {
  String adminId;
  String name;
  String email;
  String phone;
  String designation;
  bool isAdmin;
  String? imageUrl;

  AdminModel(
      {required this.adminId,
      required this.name,
      required this.email,
      required this.phone,
      required this.designation,
      required this.isAdmin,
      this.imageUrl});
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      adminFieldId: adminId,
      adminFieldName: name,
      adminFieldEmail: email,
      adminFieldPhone: phone,
      adminFieldDesignation: designation,
      adminFieldisAdmin: isAdmin,
      adminFieldimageURl: imageUrl,
    };
  }

  factory AdminModel.fromMap(Map<String, dynamic> map) => AdminModel(
      adminId: map[adminFieldId],
      name: map[adminFieldName],
      email: map[adminFieldEmail],
      phone: map[adminFieldPhone],
      designation: map[adminFieldDesignation],
      isAdmin: map[adminFieldisAdmin],
      imageUrl: map[adminFieldimageURl]);
}
