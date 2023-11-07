import 'package:flutter/material.dart';
import 'package:minipharma/pages/%20ListMed.dart';
import 'package:minipharma/pages/AjouterMed.dart';
import 'package:minipharma/pages/AjouterOrd.dart';
import 'package:minipharma/pages/ListOrd.dart';
import 'package:minipharma/pages/homepage2.dart';
import 'package:minipharma/pages/notifs.dart';
import 'package:minipharma/pages/profile1.dart';

import 'pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/home2": (context) => HomePage2Widget(),
        "/profile": (context) => Profile1Widget(),
        "/notifs": (context) => NotifsWidget(),
        "/ajoutermed": (context) => AjouterMedWidget(),
        "/ajouterord": (context) => AjouterOrdWidget(),
        "/listmed": (context) => ListMed(),
        "/listord": (context) => ListOrd(),
        "/principale": (context) => HomePageWidget(),
      },
      initialRoute: "/principale",
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //  home:HomePageWidget(),
    );
  }
}
