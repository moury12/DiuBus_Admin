const String collectiondriver = 'drivers';
const String driverFieldId = 'driverID';
const String driverFieldName = 'Name';
const String driverFieldEmail = 'Email';
const String driverFieldPhone = 'phone';
const String driverFieldage = 'age';
const String driverFieldDays = 'available days';
const String driverFieldisdriver = 'isdriver';
const String driverFieldimageURl = 'driver image';
const String driverFieldLicenseimageURl = 'driver license image';


class DriverModel {
  String driverId;
  String? driverImage;
  String driverLicenseImage;
  List<String>? daysinweek;
  String name;
  String email;
  num phone;
  num age;
  bool isDriver;

  DriverModel(
      {required this.driverId,
        required this.name,
        required this.email,
        required this.phone,
        required this.age,
        required this.isDriver,
        required this.driverLicenseImage,
        this.daysinweek,
        this.driverImage});
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      driverFieldId: driverId,
      driverFieldName: name,
      driverFieldEmail: email,
      driverFieldPhone: phone,
      driverFieldage:age ,
      driverFieldLicenseimageURl: driverLicenseImage,
      driverFieldDays:daysinweek ,
      driverFieldimageURl:driverImage,
          driverFieldisdriver:isDriver
    };
  }

  factory DriverModel.fromMap(Map<String, dynamic> map) => DriverModel(
      driverId: map[driverFieldId],
      name: map[driverFieldName],
      email: map[driverFieldEmail],
      phone: map[driverFieldPhone],
      age: map[driverFieldage],
      driverLicenseImage: map[driverFieldLicenseimageURl],
      daysinweek: map[driverFieldDays],
  driverImage: map[driverFieldimageURl],
  isDriver: map[driverFieldisdriver]);
}
