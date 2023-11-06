
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class NotifsWidget extends StatefulWidget {
  const NotifsWidget({Key? key}) : super(key: key);

  @override
  _NotifsWidgetState createState() => _NotifsWidgetState();
}

class _NotifsWidgetState extends State<NotifsWidget> {


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
        backgroundColor: Colors.blue,
        appBar: AppBar(
          backgroundColor: Color(0xFFCB4354),
          automaticallyImplyLeading: true,
          title: Text(
            'notifications',
            style: TextStyle(
              color: Colors.white,
            fontSize: 18,
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
              color:Colors.white ,
            ),
            child: Icon(
              Icons.sentiment_very_satisfied,
              color:Colors.black,
              size: 100,
            ),
          ),
        ),
      ),
    );
  }
}
