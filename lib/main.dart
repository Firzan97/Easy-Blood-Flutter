import 'package:easy_blood/admin/dashboard/dashboard.dart';
import 'package:easy_blood/chat/chat_home.dart';
import 'package:easy_blood/home/home.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'file:///C:/Users/Firza/AndroidStudioProjects/easy_blood/lib/chat/message_screen.dart';
import 'package:easy_blood/onboarding.dart';
import 'package:easy_blood/profile/edit_profile.dart';
import 'package:easy_blood/profile/profile.dart';
import 'package:easy_blood/splash.dart';
import 'package:easy_blood/test.dart';
import 'package:easy_blood/welcome/requirement.dart';
import 'package:easy_blood/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:easy_blood/socketIoChat/main.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main()async {
  await DotEnv().load('.env');
  runApp(MaterialApp(home: MyApp()));}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Muli",
      ),
      debugShowCheckedModeBanner: false,
      home: Splash(),
      routes: <String, WidgetBuilder>{
        '/onboarding': (BuildContext context) => Onboarding(),
        '/home': (BuildContext context) => Home(),
        '/welcome': (BuildContext context) => Welcome(),
        '/loading': (BuildContext context) => LoadingScreen(),
        '/test': (BuildContext context) => MyHomePage(),
        '/profile': (BuildContext context) => Profile(),
        '/editprofile': (BuildContext context) => EditProfile(),
        '/dashboard': (BuildContext context) => Dashboard(),
        '/secondScreen': (BuildContext context) => HomeApp(),
        '/messageScreen': (BuildContext context) => MessageScreen(),
        '/homepage': (BuildContext context) => ChatHome(),
        '/requirementForm': (BuildContext context) => RequirementForm(),

      }
    );
  }
}

