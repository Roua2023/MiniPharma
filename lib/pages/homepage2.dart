
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minipharma/pages/%20ListMed.dart';
import 'package:minipharma/pages/ListOrd.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';


class HomePage2Widget extends StatefulWidget {
  const HomePage2Widget({Key? key}) : super(key: key);

  @override
  _HomePage2WidgetState createState() => _HomePage2WidgetState();
}

class _HomePage2WidgetState extends State<HomePage2Widget> {


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
        backgroundColor:Colors.indigo,
        appBar: AppBar(
          backgroundColor: Color(0xFFCB4354),
          automaticallyImplyLeading: true,
          title: Text(
            'Pharmacity',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Open Sans Condensed',
              fontSize: 40,
              letterSpacing: 3,
              fontStyle: FontStyle.italic,
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
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [


              FlipCard(


                  direction: FlipDirection.HORIZONTAL,
                  speed: 400,

                  front:  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListMed()),
                      );
                    },
                    child:Container(

                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(

                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/medicine.png'),
                      ),
                      borderRadius: BorderRadius.circular(12),
                      shape: BoxShape.rectangle,
                    ),
                  ),),
                  back: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/medicine.png'),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.00, 0.00),

                    ),
                  ),
                ),
                SizedBox(height: 50), // Add spacing between the cards
                FlipCard(
                  direction: FlipDirection.HORIZONTAL,
                  speed: 400,
                  front:GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListOrd()),
                      );
                    },
                    child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(

                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/medical-prescription.png'),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),),
                  back: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/medical-prescription.png'),
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.00, 0.00),

                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: Color(0xFFCB4354),
          items: <Widget>[
            Icon(
              Icons.home,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.notifications,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.person,
              size: 30,
              color: Colors.white,
            ),

          ],
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.pushNamed(context, '/home2'); // Accueil
                break;
              case 1:
                Navigator.pushNamed(context, '/notifs'); // Notifications
                break;
              case 2:
                Navigator.pushNamed(context, '/profile'); // Profil
                break;
            }
          },
        ),
      ),
    );
  }
}
