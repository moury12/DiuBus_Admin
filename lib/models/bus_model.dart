const String collectionBus = 'Bus';
const String busFieldId = 'busID';
const String busFieldImage = 'Image';
const String busFieldName = 'Bus Name';
const String busFieldType = 'Bus type';
const String busFieldDestination = 'Destination';
const String busFieldPassengerCategory = 'PassengerCategory';
const String busFieldStudentRent = 'studentRent';
const String busFieldFacultyRent = 'facultyRent';

class BusModel {
  String? busId;
  String? busImage;
  String busName;
  String busType;
  String destination;
  String passengerCategory;
  num studentRent;
  num facultyRent;

  BusModel(
      {this.busId,
      this.busImage,
       required this.busName,
      required this.busType,
      required this.destination,
      required this.passengerCategory,
      required this.studentRent,
      required this.facultyRent});
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      busFieldId: busId,
      busFieldImage: busImage,
      busFieldName:busName,
      busFieldType: busType,
      busFieldDestination: destination,
      busFieldPassengerCategory: passengerCategory,
      busFieldStudentRent: studentRent,
      busFieldFacultyRent: facultyRent,
    };
  }

  factory BusModel.fromMap(Map<String, dynamic> map) => BusModel(
      busId: map[busFieldId],
      busImage: map[busFieldImage],
      busName: map[busFieldName],
      busType: map[busFieldType],
      destination: map[busFieldDestination],
      passengerCategory: map[busFieldPassengerCategory],
      studentRent: map[busFieldStudentRent],
      facultyRent: map[busFieldFacultyRent]);
}
