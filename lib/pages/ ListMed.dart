import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
//import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../widgets/ItemWidget.dart';
import '../widgets/ListMedAppBar.dart';

class ListMed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        ListMedAppBar(),
        Container(
            //height: 500,
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Color(0xFFB2DFDB),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35)),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        height: 50,
                        width: 260,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search here",
                          ),
                        ),
                      ),
                      Icon(
                        Icons.camera_alt,
                        size: 27,
                        color: Color(0xFF4C53A5),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 30,
                  ),
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/ajoutermed");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              size: 27,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Ajouter Medicament",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /*  Text(
                        "Tous les medicaments",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),*/
                    ],
                  ),
                ),
                ItemWidget(),
              ],
            )),
      ]),
      /*  bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Color(0xFF4C53A5),
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
            Icons.face,
            size: 30,
            color: Colors.white,
          ),

        ],
        onTap: (index) {
          // GÃ©rez ici le changement d'onglet
        },
      ),*/
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
    );
  }
}
