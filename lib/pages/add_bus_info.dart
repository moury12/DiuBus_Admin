import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:transpor_guidance_admin/models/bus_model.dart';
import 'package:transpor_guidance_admin/pages/dashboard_page.dart';
import 'package:transpor_guidance_admin/providers/bus_provider.dart';

import '../utils/constants.dart';

class AddBusPage extends StatefulWidget {
  static const String routeName ='/add';
  const AddBusPage({Key? key}) : super(key: key);

  @override
  State<AddBusPage> createState() => _AddBusPageState();
}

class _AddBusPageState extends State<AddBusPage> {
final busNameController=TextEditingController();
final busRentStudentController=TextEditingController();
final busRentFacultyController=TextEditingController();
String passengerTypeGroupValue ='Student';
String busTypeGroupValue ='Regular Transport';
String? destination;
String? busImage;
late BusProvider busProvider;
@override
  void didChangeDependencies() {
   busProvider=Provider.of<BusProvider>(context,listen: false);
    super.didChangeDependencies();
  }
@override
void dispose() {
  busNameController.dispose();
  busRentStudentController.dispose();
  busRentFacultyController.dispose();
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
                child: Text('Add BusInfo',
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [


                InkWell(
                  onTap: (){_getBusImage(ImageSource.gallery);},
                  child:busImage==null? Image.asset('assets/icon6.png',height: 90,width: 90,):Image.file(File(busImage!)),
                ),
                Expanded(flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      controller: busNameController,
                      decoration: InputDecoration(hintText: 'Bus Name', suffixIcon: Icon(Icons.directions_bus)),
                    ),
                  ),

            ),
Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Text('Select Bus type',style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold,fontSize: 15),),
),

Row(
  children: [
    Radio<String>(value: 'Regular Transport', groupValue: busTypeGroupValue, onChanged: (value){
        setState(() {
          busTypeGroupValue=value!;

        });              }),
    Text('Regular Transport'),
  ],
),
Row(children: [Radio<String>(value: 'Shuttle service', groupValue: busTypeGroupValue, onChanged: (value){
  setState(() {
    busTypeGroupValue=value!;

  });              }),
  Text('Shuttle service'),],),
Row(children: [ Radio<String>(value: 'Female Bus', groupValue: busTypeGroupValue, onChanged: (value){
  setState(() {
    busTypeGroupValue=value!;

  });              }),
  Text('Female Bus'),],),




         Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Select Passenger Category ',style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold,fontSize: 15),),
            ),
            Row(
              children: [
                Radio<String>(value: 'Faculty', groupValue: passengerTypeGroupValue, onChanged: (value){
setState(() {
  passengerTypeGroupValue=value!;

});              }),
                Text('Faculty'),  Radio<String>(value: 'Student', groupValue: passengerTypeGroupValue, onChanged: (value){
setState(() {
  passengerTypeGroupValue=value!;

});              }),
                Text('Student'),  Radio<String>(value: 'Stuff', groupValue: passengerTypeGroupValue, onChanged: (value){
setState(() {
  passengerTypeGroupValue=value!;

});              }),
                Text('Stuff'),
              ],
            ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(flex: 1,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: 'Rent for Student',
                    suffixIcon: Icon(Icons.attach_money)),
                    controller: busRentStudentController,

                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton(
                onPressed: _saveBus,
                child: Icon(Icons.save_alt),backgroundColor: Colors.lightBlueAccent.shade100,
              ),
            ),
          ],
        ),
      ),

    );
  }


  void _saveBus() async{
if(busNameController.text.isEmpty){
  showMsg(context, 'Please provide a name');
  return;
}
if(destination==null){
  showMsg(context, 'Field required');
  return;

}if(busRentStudentController.text.isEmpty){
  showMsg(context, 'Field required');
  return;
}
EasyLoading.show(status:'Please wait' );
final downloadurl =
await busProvider.uploadImage(busImage!);

final busModel=BusModel(busName: busNameController.text,
    busImage:downloadurl,busType: busTypeGroupValue, destination: destination!, passengerCategory: passengerTypeGroupValue, studentRent: int.parse(busRentStudentController.text), facultyRent:0);
try{
  await busProvider.addBus(busModel);
  EasyLoading.dismiss();
  if(mounted){
    showMsg(context, "Bus Added");
    Navigator.pushReplacementNamed(context, DashboardPage.routeName);
  }
}catch(error){
  EasyLoading.dismiss();
  rethrow;
}
  }

  void _getBusImage(ImageSource gallery) async {
    final pickedImage=await ImagePicker().pickImage(source: gallery,imageQuality: 70);
    if(pickedImage!=null){
      setState(() {
       busImage=pickedImage.path;
      });
    }
  }
}
