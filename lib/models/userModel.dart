
const String collectionUser = 'Users';
const String userFieldId = 'userID';
const String userFieldName = 'Name';
const String userFieldversityId = 'vId';
const String userFieldaddress = 'Adress';
const String userFieldDepartment = 'department';
const String userFieldEmail = 'Email';
const String userFieldPhone = 'phone';
const String userFieldGender= 'Gender';
const String userFieldsemester= 'Semester';
const String userFieldDesignation = 'Designation';
const String userFieldisUser = 'isuser';
const String userFieldimageURl = 'imageURl';
class UserModel {
  String userId;
  String? versityId;
  String? address;
  String? department;
  String name;
  String email;
  String? gender;
  String? semester;
  String phone;
  String? designation;
  bool isUser;
  String? imageUrl;

  UserModel(
      {required this.userId,
        required this.name,
        required this.email,
        required this.phone,
         this.designation,
        required this.isUser,
        this.imageUrl,
        this.semester,
        this.gender,
        this.versityId,
        this.address,
        this.department
      });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      userFieldId: userId,
      userFieldName: name,
      userFieldEmail: email,
      userFieldPhone: phone,
      userFieldGender: gender,
      userFieldsemester: semester,
      userFieldversityId: versityId,
      userFieldaddress: address,
      userFieldDepartment: department,
      userFieldDesignation: designation,
      userFieldisUser: isUser,
      userFieldimageURl: imageUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
      userId: map[userFieldId],
      name: map[userFieldName],
      email: map[userFieldEmail],
      phone: map[userFieldPhone],
      gender: map[userFieldGender],
      semester: map[userFieldsemester],
      versityId: map[userFieldversityId],
      address: map[userFieldaddress],
      department: map[userFieldDepartment],
      designation: map[userFieldDesignation],
      isUser: map[userFieldisUser],
      imageUrl: map[userFieldimageURl]);
}
