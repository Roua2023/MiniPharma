import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/ListMedAppBar.dart';

class DetailsMedicament extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // Utilisation de l'appBar pour afficher le titre
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlue.shade300, Colors.cyan],
          ),
        ),
        child: Center(
          child: Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            elevation: 5,
            color: Colors.transparent,
            child: Container(
              width: 300,
              height: 500,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade300, Colors.white],
                ),
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Image.asset(
                      'assets/images/img5.jpg',
                      fit: BoxFit.cover,
                      height: 100,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      children: [
                        Text(
                          'nom',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text('Date expiration : 2003/2/01', textAlign: TextAlign.center),
                        Text('Type : test', textAlign: TextAlign.center),
                        Text('Quantité : qte', textAlign: TextAlign.center),
                        Text('Forme : forme', textAlign: TextAlign.center),
                        Text('Posologie : pos', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.blue,
                          size: 24.0,
                        ),
                        onPressed: () {
                          // Action à exécuter lorsque le bouton "Modifier" est cliqué.
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete_forever,
                          color: Colors.blue,
                          size: 24.0,
                        ),
                        onPressed: () {
                          // Action à exécuter lorsque le bouton "Supprimer" est cliqué.
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/listmed');
                    },
                    child: Text('Retour'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
