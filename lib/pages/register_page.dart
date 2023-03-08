import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:transpor_guidance_admin/Authservice/authservice.dart';
import 'package:transpor_guidance_admin/models/admin_model.dart';
import 'package:transpor_guidance_admin/pages/login_page.dart';
import 'package:transpor_guidance_admin/providers/admin_provider.dart';
import 'package:transpor_guidance_admin/utils/constants.dart';
class RegisterPage extends StatefulWidget {
  static const String routeName ='/reg';
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
String? designation;
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
String errmsg='';
  final _passwordController = TextEditingController();
  late AdminProvider adminProvider;
@override
  void didChangeDependencies() {
  adminProvider=Provider.of<AdminProvider>(context, listen: false);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal.shade200,title: Text('Register as Transport Suporvisor',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600,fontSize: 14),),),
        body: Stack(

          children: [Image.asset('assets/b2.jpg',height: double.infinity, width: double.infinity,fit: BoxFit.cover,),
            Positioned(top: 10,
                left: 0,
                right: 0,
                child: Image.asset('assets/logo2.png',height: 200,width: 200,)),

            Positioned( top: 150,
              left: 20,
              right: 20,
              child: Form(key: _formKey,
                child:
                 ListView(
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(

                          suffixIcon: Icon(Icons.person),
                          labelText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Provide a valid Name';
                        }
                        return null;
                      },
                    ), TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(

                          suffixIcon: Icon(Icons.email),
                          labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Provide a valid email address';
                        }
                        return null;
                      },
                    ), TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(

                          suffixIcon: Icon(Icons.phone),
                          labelText: 'Phone no'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Provide a valid phone number';
                        }
                        return null;
                      },
                    ),SizedBox(height: 10,),
                    DropdownButton<String>(
                      icon: Icon(Icons.work),
                        value: designation,
                        hint: Text('Select Designation'),
                        isExpanded: true,
                        items: designations
                            .map((designation) => DropdownMenuItem<String>(
                            value: designation, child: Text(designation,style: TextStyle(color: Colors.black54,))))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            designation = value;
                          });
                        }),  Divider(
                      height: 2,
                      color: Colors.black,
                    ),

                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.key),
                          labelText: 'Password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Provide a valid Password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    FloatingActionButton(onPressed: _register, child: Icon(Icons.done, size: 30, color: Colors.white,),backgroundColor: Colors.teal.shade200,),

                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(errmsg,style: TextStyle(color: Colors.red, fontWeight: FontWeight.w100,fontSize: 8)),
                    ),
                  ],
                ),
              )),

          ],
        )
    );

  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
_nameController.dispose();
_phoneController.dispose();
    super.dispose();
  }

  void _register() async{
    if(_formKey.currentState!.validate()){
      EasyLoading.show(status: 'please wait');
      final email=_emailController.text;
      final password =_passwordController.text;
    try{

      UserCredential credential;
   credential=  await AuthService.register(email, password);
     final adminModel = AdminModel(adminId: credential.user!.uid, name: _nameController.text, email: credential.user!.email!, phone: _phoneController.text, designation: designation!,imageUrl:credential.user!.photoURL,isAdmin: true );
     await adminProvider.addAdmin(adminModel);
     EasyLoading.dismiss();
     if(mounted){
   showMsg(context, "congratulations, you register as Transport Supervisor");
       Navigator.pushReplacementNamed(context, LoginPage.routeName);
     }
    }on FirebaseAuthException catch(error){
      EasyLoading.dismiss();
setState(() {
  errmsg =error.message!;
});
    }

    }
  }
}
