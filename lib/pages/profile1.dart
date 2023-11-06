
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class Profile1Widget extends StatefulWidget {
  const Profile1Widget({Key? key}) : super(key: key);

  @override
  _Profile1WidgetState createState() => _Profile1WidgetState();
}

class _Profile1WidgetState extends State<Profile1Widget> {


  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {


    return GestureDetector(

      child: Scaffold(
        key: scaffoldKey,

        appBar: AppBar(
          backgroundColor: Color(0xFFCB4354),
          automaticallyImplyLeading: true,
          title: Text(
            'profile user',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,

            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 4,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              
            ),
            child: Icon(
              Icons.sentiment_very_satisfied,
              color: Colors.black,
              size: 100,
            ),
          ),
        ),
      ),
    );
  }
}
