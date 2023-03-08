import 'package:transpor_guidance_admin/models/bus_model.dart';
import 'package:transpor_guidance_admin/models_for_driver/driver_model.dart';
const String collectionSchedule = 'Schedule';
const String scheduleFieldbusModel = 'bus';
const String scheduleFieldid = 'id';
const String scheduleFieldstartTime = 'startTime';
const String scheduleFielddepartureTime = 'departureTime';
const String scheduleFieldfrom = 'from';
const String scheduleFielddestination = 'destination';
const String scheduleFieldroutes = 'routes';
const String scheduleFieldsemester = 'semester';
const String scheduleFielddriverModel = 'driver';
class ScheduleModel{
  BusModel busModel;
String startTime;
String? id;
String departureTime;
String from;
String destination;
String? routes;
String? semester;
DriverModel? driverModel;

ScheduleModel(
      {required this.busModel,
        this.id,
        required this.startTime,
     required this.departureTime,
    required  this.from,
    required  this.destination,
      this.routes,
      this.semester,
      this.driverModel});
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      scheduleFieldid:id,
      scheduleFieldbusModel: busModel.toMap(),
      scheduleFieldstartTime: startTime,
      scheduleFielddepartureTime: departureTime,
      scheduleFieldfrom: from,
      scheduleFielddestination: destination,
      scheduleFieldroutes: routes,
      scheduleFieldsemester: semester,
      scheduleFielddriverModel: driverModel?.toMap(),
    };
  }

  factory ScheduleModel.fromMap(Map<String, dynamic> map) => ScheduleModel(
    busModel: BusModel.fromMap(map[scheduleFieldbusModel]),
    startTime: map[scheduleFieldstartTime],
    id: map[scheduleFieldid],
    departureTime: map[scheduleFielddepartureTime],
    from: map[scheduleFieldfrom],
    destination: map[scheduleFielddestination],
    routes: map[scheduleFieldroutes],
    semester: map[scheduleFieldsemester],
    driverModel: map[scheduleFielddriverModel]==null?null
        :DriverModel.fromMap(map[scheduleFielddriverModel]),
  );
}