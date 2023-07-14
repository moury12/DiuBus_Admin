import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:transpor_guidance_admin/models/bus_model.dart';
import 'package:transpor_guidance_admin/models/driver_model.dart';
import 'package:transpor_guidance_admin/models/schedule_model.dart';
import 'package:transpor_guidance_admin/providers/bus_provider.dart';
import 'package:transpor_guidance_admin/providers/driver_provider.dart';

import '../utils/constants.dart';
import 'dashboard_page.dart';

class SchedulePage extends StatefulWidget {
  static const String routeName = '/schedule';
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final semesterController = TextEditingController();
  final details = TextEditingController();
  String? busImage;
  @override
  void dispose() {
    super.dispose();

    semesterController.dispose();
    details.dispose();
  }
  late BusProvider busProvider;
  @override
  void didChangeDependencies() {
    busProvider = Provider.of<BusProvider>(context, listen: false);
    super.didChangeDependencies();
  }
  BusModel? busModel;
  DriverModel? driverModel;
  TimeOfDay startTime = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay departureTime = TimeOfDay(hour: 00, minute: 00);

  String? city;
  String? city1;
  @override


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
                child: Text('Set Schedule',
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                    onPressed: selectstarttime,
                    icon: Icon(Icons.watch_later_outlined),
                    label: Text(startTime.hour == 0
                        ? 'Start Time'
                        : startTime.format(context).toString())),
                TextButton.icon(
                    onPressed: selectDeparturetime,
                    icon: Icon(Icons.departure_board),
                    label: Text(departureTime.hour == 0
                        ? 'Departure Time'
                        : departureTime.format(context).toString())),
              ],
            ),
          ),  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child:
                  Stack(clipBehavior: Clip.none,
                    children: [
                      Image.asset('assets/icons7.png',height: 70,width: 70,),
                      Positioned(top: -5,
                          right: -5,

                          child: Icon(Icons.add_circle,size: 30, color: Colors.black,))
                    ],
                  ),
                  onTap: () {
                    _getBusImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
          Consumer<BusProvider>(
            builder: (context, provider, child) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<BusModel>(
                  hint: const Text('Select Bus'),
                  value: busModel,
                  isExpanded: true,
                  validator: (value) {
                    if (value == null) {
                      return 'please select a Bus';
                    }
                    return null;
                  },
                  items: provider.busList
                      .map((busModel) => DropdownMenuItem(
                          value: busModel, child: Text(busModel.busName)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      busModel = value;
                    });
                  }),
            ),
          ),
          Consumer<DriverProvider>(
            builder: (context, provider, child) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<DriverModel>(
                  hint: const Text('Assign driver'),
                  value: driverModel,
                  isExpanded: true,
                  validator: (value) {
                    if (value == null) {
                      return 'please select a driver';
                    }
                    return null;
                  },
                  items: provider.driverList
                      .map((driverModel) => DropdownMenuItem(
                          value: driverModel, child: Text(driverModel.name)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      driverModel = value;
                    });
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
                value: city,
                hint: Text('From'),
                isExpanded: true,
                items: subDistricts
                    .map((city) => DropdownMenuItem<String>(
                        value: city, child: Text(city)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    city = value;
                  });
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
                value: city1,
                hint: Text('To'),
                isExpanded: true,
                items: subDistricts
                    .map((city) => DropdownMenuItem<String>(
                        value: city, child: Text(city)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    city1 = value;
                  });
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLines: 2,
              controller: semesterController,
              decoration: InputDecoration(hintText: 'Semester'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FloatingActionButton(
              onPressed: _saveSchedule,
              child: Icon(Icons.save_alt),backgroundColor: Colors.lightBlueAccent.shade100,
            ),
          ),
        ],
      ),
    );
  }

  void selectstarttime() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        startTime = value!;
      });
    });
  }

  void selectDeparturetime() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        departureTime = value!;
      });
    });
  }

  void _saveSchedule() async {
    if (semesterController.text.isEmpty) {
      showMsg(context, 'Field required');
      return;
    }

    if (city == null) {
      showMsg(context, 'Field required');
      return;
    }
    if (city1 == null) {
      showMsg(context, 'Field required');
      return;
    }
    if (busModel == null) {
      showMsg(context, 'Field required');
      return;
    }
    EasyLoading.show(status: 'Please wait');
    EasyLoading.show(status: 'Please wait');
    final downloadurl = await busProvider.uploadImage(busImage);
    final schedule = ScheduleModel(id: DateTime.now().millisecondsSinceEpoch.toString(),
        busModel: busModel!,driverModel: driverModel,
        startTime: startTime.format(context).toString(),
        departureTime: departureTime.format(context).toString(),
        routes: downloadurl,
        from: city!,semester: semesterController.text,
        destination: city1!);
    try {
      await busProvider.addSchedule(schedule);
      EasyLoading.dismiss();
      if (mounted) {
        showMsg(context, "set Schedule");
        Navigator.pushReplacementNamed(context, DashboardPage.routeName);
      }
    } catch (error) {
      EasyLoading.dismiss();
      rethrow;
    }
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
}
