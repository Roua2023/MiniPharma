import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:minipharma/pages/ListOrd.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class TypesOrdonnances extends StatefulWidget {
  const TypesOrdonnances({Key? key}) : super(key: key);

  @override
  _TypesOrdonnancesState createState() => _TypesOrdonnancesState();
}

class _TypesOrdonnancesState extends State<TypesOrdonnances> {
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
            'Pharmacity',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Open Sans Condensed',
              fontSize: 30,
              letterSpacing: 3,
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
          child: Column(
            children: [
              // Titre
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Les catégories des ordonnances',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              // Grille
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  children: [
                    buildFlipCard(
                      'assets/ord/cardio.png',
                      'Cardiologue',
                      'Texte en dessous de la première carte',
                      'cardio',
                    ),
                    buildFlipCard(
                      'assets/ord/dermato.png',
                      'Dermatologue',
                      'Texte en dessous de la deuxième carte',
                      'Dermatologue',
                    ),
                    buildFlipCard(
                      'assets/ord/dentiste.png',
                      'Dentiste',
                      'Texte en dessous de la troisième carte',
                      'dentiste',
                    ),
                    buildFlipCard(
                      'assets/ord/orpha.png',
                      'Orphelinat',
                      'Texte en dessous de la quatrième carte',
                      'Orphelinat',
                    ),
                    buildFlipCard(
                      'assets/ord/gastro.png',
                      'Gastro-entérologue',
                      'Texte en dessous de la cinquième carte',
                      'gastro',
                    ),
                    buildFlipCard(
                      'assets/ord/pédiatre.png',
                      'Pédiatre',
                      'Texte en dessous de la sixième carte',
                      'pediatre',
                    ),
                    buildFlipCard(
                      'assets/ord/diabéthique.png',
                      'Diabétologue',
                      'Texte en dessous de la première carte',
                      'Diabétologue',
                    ),
                    buildFlipCard(
                      'assets/ord/neuro.png',
                      'Neurologue',
                      'Texte en dessous de la première carte',
                      'Neurologue',
                    ),
                  ],
                ),
              ),
            ],
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

  Widget buildFlipCard(String imagePath, String frontText, String backText, String specialty) {
    return Column(
      children: [
        FlipCard(
          direction: FlipDirection.HORIZONTAL,
          speed: 400,
          front: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListOrd(specialite: specialty)),
              );
            },
            child: Container(
              child: Image.asset(
                imagePath,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
          back: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(imagePath),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  backText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Texte en dessous de la carte
        Container(
          alignment: Alignment.center,
          child: Text(
            frontText,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
