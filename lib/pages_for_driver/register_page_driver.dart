import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:transpor_guidance_admin/Authservice/authservice.dart';
import 'package:transpor_guidance_admin/models_for_driver/driver_model.dart';
import 'package:transpor_guidance_admin/providers/driver_provider.dart';

import '../pages/login_page.dart';
import '../utils/constants.dart';

class RegisterDriverPage extends StatefulWidget {
  static const String routeName = '/regdr';
  const RegisterDriverPage({Key? key}) : super(key: key);

  @override
  State<RegisterDriverPage> createState() => _RegisterDriverPageState();
}

class _RegisterDriverPageState extends State<RegisterDriverPage> {
  final _formKey = GlobalKey<FormState>();
  String? thumbnailImageLocalPath;
  String? licenseImageLocalPath;
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String errmsg = '';
  final _passwordController = TextEditingController();
  late DriverProvider driverProvider;
  @override
  void didChangeDependencies() {
    driverProvider=Provider.of<DriverProvider>(context, listen: false);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade200,
          title: Text(
            'Register as Driver',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),),
        ),
        body: Stack(
          children: [
            Image.asset(
              'assets/b2.jpg',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  shrinkWrap: true,
                  children: [SizedBox(height: 20,),
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Container(
                               height: 100,
                               width: 100,
                                child: Stack(clipBehavior: Clip.none,
                                  children: [
                                    Center(
                                      child: thumbnailImageLocalPath == null? Image.asset(
                                        'assets/icon4.png',
                                        height: 70,
                                        width: 70,
                                      ):ClipRRect(borderRadius: BorderRadius.circular(90),
                                        child: Image.file(File(thumbnailImageLocalPath!), height: 100,
                                          width: 100,fit: BoxFit.cover,),
                                      )
                                    ),Positioned(
                               top:100,
                               left:13,child:thumbnailImageLocalPath == null?Text('Upload Image',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10)):Text(''),),
                                    Positioned(bottom: -8,
                                      right: -8,
                                      child:thumbnailImageLocalPath == null? FloatingActionButton.small(heroTag: "btn1",
                                          backgroundColor: Colors.cyanAccent,
                                          onPressed: () {_getImage(ImageSource.gallery);},
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,size: 30,
                                          )):Text(''),
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(color: Colors.white70,
                                    border:
                                        Border.all(width: 1, color: Colors.black54),
                                    shape: BoxShape.circle),

                           ),

                        Container(

                                  child: Stack(clipBehavior: Clip.none,
                                    children: [
                                     licenseImageLocalPath==null? Image.asset(
                                        'assets/icon8.png',
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.contain,
                                      ):ClipRRect(borderRadius: BorderRadius.circular(90),
                                       child: Image.file(File(licenseImageLocalPath!), height: 100,
                                         width: 100,fit: BoxFit.cover,),
                                     ),Positioned(
                                        top:102,
                                        right: 0,
                                        child:licenseImageLocalPath==null? Text('Attach driving license ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10)):Text(''),
                                      ),
                                         Positioned(bottom: -8,
                                           right: -8,
                                           child:licenseImageLocalPath==null? FloatingActionButton.small(heroTag: "btn2",
                                              onPressed: () {_getImage1(ImageSource.gallery);},
                                               backgroundColor: Colors.cyanAccent,
                                              child: Icon(
                                                Icons.edit,
                                                color: Colors.white,size: 30,
                                              )
                                      ):Text(''),
                                         )
                                    ],
                                  ),
                                  decoration: BoxDecoration(color: Colors.white70,
                                      border: Border.all(
                                          width: 1, color: Colors.black54),
                                      shape: BoxShape.circle),
                         ),
                        ],
                      ),
                  ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MultiSelectDropDown(
                          backgroundColor: Colors.transparent,
                          optionsBackgroundColor: Colors.transparent,
                          borderWidth: 1,
                          onOptionSelected:
                              (List<ValueItem> selectedOptions) {},
                          hint: 'Select Available Days',
                          options: <ValueItem>[
                            ValueItem(label: 'Saturday', value: '1'),
                            ValueItem(label: 'Sunday', value: '2'),
                            ValueItem(label: 'Monday', value: '3'),
                            ValueItem(label: 'Tuesday', value: '4'),
                            ValueItem(label: 'Wednesday', value: '5'),
                            ValueItem(label: 'Thursday', value: '6'),
                            ValueItem(label: 'Friday', value: '7'),
                          ],
                          selectionType: SelectionType.multi,
                          hintStyle: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                          chipConfig: const ChipConfig(
                              wrapType: WrapType.wrap,
                              backgroundColor: Colors.redAccent,
                              autoScroll: true),
                          dropdownHeight: 250,
                          optionTextStyle: const TextStyle(fontSize: 16),
                          selectedOptionIcon: const Icon(Icons.check_circle)),
                    ),
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.person), labelText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Provide a valid Name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.email), labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Provide a valid email address';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.phone), labelText: 'Phone no'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Provide a valid phone number';
                        }
                        return null;
                      },
                    ), TextFormField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.calendar_month_outlined), labelText: 'Age'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Provide a valid age';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.key), labelText: 'Password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Provide a valid Password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FloatingActionButton(heroTag: "btn3",
                      onPressed: registerAsdriver,
                      child: Icon(
                        Icons.done,
                        size: 30,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.teal.shade200,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(errmsg,
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w100,
                              fontSize: 8)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }


  void _getImage(ImageSource imageSource) async {
    final pickedImage = await ImagePicker().pickImage(
      source: imageSource,
      imageQuality: 70,
    );
    if (pickedImage != null) {
      setState(() {
        thumbnailImageLocalPath = pickedImage.path;
      });
    }
  }
  void _getImage1(ImageSource imageSource) async {
    final pickedImage = await ImagePicker().pickImage(
      source: imageSource,
      imageQuality: 70,
    );
    if (pickedImage != null) {
      setState(() {
        licenseImageLocalPath = pickedImage.path;
      });
    }
  }



  void registerAsdriver() async {
    if(_formKey.currentState!.validate()){
      EasyLoading.show(status: 'please wait');
      final email=_emailController.text;
      final password =_passwordController.text;
    try{
     final downloadurl =
      await driverProvider.uploadImage(thumbnailImageLocalPath!);
     final downloadurl2 =
      await driverProvider.uploadImage(licenseImageLocalPath!);
      UserCredential credential;
      credential=  await AuthService.register(email, password);
    final drivers=DriverModel(driverId: credential.user!.uid, name: _nameController.text, email: _emailController.text, phone: int.parse(_phoneController.text), age: int.parse(_ageController.text), isDriver: true, driverLicenseImage: downloadurl2,driverImage: downloadurl);
    await driverProvider.registerDrivers(drivers);
      EasyLoading.dismiss();
      if(mounted){
        showMsg(context, "congratulations, you register as driver");
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }}
    on FirebaseAuthException catch(error){
      EasyLoading.dismiss();
      setState(() {
        errmsg =error.message!;
      });
    }}
  }
  @override
  void dispose() {
    _emailController.dispose();
    _ageController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

}
