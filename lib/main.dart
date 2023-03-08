import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:transpor_guidance_admin/pages/add_bus_info.dart';
import 'package:transpor_guidance_admin/pages/dashboard_page.dart';
import 'package:transpor_guidance_admin/pages/drivers_page.dart';
import 'package:transpor_guidance_admin/pages/home_page.dart';
import 'package:transpor_guidance_admin/pages/login_page.dart';
import 'package:transpor_guidance_admin/pages/notice_page.dart';
import 'package:transpor_guidance_admin/pages/notification_page.dart';
import 'package:transpor_guidance_admin/pages/policy_page.dart';
import 'package:transpor_guidance_admin/pages/register_page.dart';
import 'package:transpor_guidance_admin/pages/schedule_page.dart';
import 'package:transpor_guidance_admin/pages/users_page.dart';
import 'package:transpor_guidance_admin/pages_for_driver/dashboard_page_driver.dart';
import 'package:transpor_guidance_admin/pages_for_driver/register_page_driver.dart';
import 'package:transpor_guidance_admin/providers/admin_provider.dart';
import 'package:transpor_guidance_admin/providers/driver_provider.dart';
import 'pages/launcher_page.dart';
import 'providers/bus_provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=>AdminProvider()),
    ChangeNotifierProvider(create: (context)=>BusProvider()),
    ChangeNotifierProvider(create: (context)=>DriverProvider()),
  ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transport Guideance',
      theme: ThemeData(
        textTheme: GoogleFonts.prataTextTheme(),
        primarySwatch: Colors.blueGrey,
      ),
      builder: EasyLoading.init(),
    initialRoute: LauncherPage.routeName,
    routes: {
LauncherPage.routeName:(_)=>const LauncherPage(),
DashboardPage.routeName:(_)=>const DashboardPage(),
DashboardDriverPage.routeName:(_)=>const DashboardDriverPage(),
LoginPage.routeName:(_)=>const LoginPage(),
RegisterPage.routeName:(_)=>const RegisterPage(),
RegisterDriverPage.routeName:(_)=>const RegisterDriverPage(),
HomePage.routeName:(_)=>const HomePage(),
NotificationPage.routeName:(_)=>const NotificationPage(),
AddBusPage.routeName:(_)=>const AddBusPage(),
SchedulePage.routeName:(_)=>const SchedulePage(),
UserPage.routeName:(_)=>const UserPage(),
DriversPage.routeName:(_)=>const DriversPage(),
NoticePage.routeName:(_)=>const NoticePage(),
PolicyPage.routeName:(_)=>const PolicyPage(),
    },
    );
  }
}



