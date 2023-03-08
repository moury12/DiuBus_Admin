import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:transpor_guidance_admin/models/bus_model.dart';
import 'package:transpor_guidance_admin/pages/dashboard_page.dart';
import 'package:transpor_guidance_admin/pages/home_page.dart';
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
      appBar: AppBar(title:
          Image.asset('assets/logo2.png',height: 70,width: 70,),
         actions: [
           Padding(
             padding: const EdgeInsets.only(right: 2.0),

             child: Center(child: Text('Assign Bus Information ',style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold,fontSize: 15))),
           ), Padding(
             padding: const EdgeInsets.all(2.0),
             child: IconButton(onPressed: _saveBus ,icon: Icon(Icons.save, size: 25, color: Colors.teal.shade200,),),
           ),

         ],

      backgroundColor: Colors.white,elevation: 0,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [


                InkWell(
                  onTap: (){_getBusImage(ImageSource.gallery);},
                  child:busImage==null? Image.asset('assets/icon6.png',height: 90,width: 90,):Image.file(File(busImage!)),
                ),
                Expanded(
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
              child:
DropdownButton<String>(
  value: destination,
  hint: Text('Select Destination'),
  isExpanded:true,
  items:subDistricts.map((destination) => DropdownMenuItem<String>(child: Text(destination),value: destination,)).toList(),
  onChanged: (value){
    setState(() {
      destination=value;
    });
  }
)
            ),
    Padding(
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
),
        ],
      ),
    ),

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
                child: Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: 'Rent for Student',
                    suffixIcon: Icon(Icons.attach_money)),
                    controller: busRentStudentController,

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: 'Rent for Faculty', suffixIcon: Icon(Icons.attach_money)),
                    controller: busRentFacultyController,
                  ),
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
}
if(busRentFacultyController.text.isEmpty){
  showMsg(context, 'Field required');
  return;
}if(busRentStudentController.text.isEmpty){
  showMsg(context, 'Field required');
  return;
}
EasyLoading.show(status:'Please wait' );
final busModel=BusModel(busName: busNameController.text, busImage:busImage,busType: busTypeGroupValue, destination: destination!, passengerCategory: passengerTypeGroupValue, studentRent: int.parse(busRentStudentController.text), facultyRent: int.parse(busRentFacultyController.text));
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
