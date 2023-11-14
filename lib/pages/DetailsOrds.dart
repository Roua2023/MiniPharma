import 'package:flutter/material.dart';
import '../services/OrdonnanceService.dart';
import '../models/Ordonnance.dart';

class DetailsOrdonnances extends StatelessWidget {
  final int? ordonnanceId;


  const DetailsOrdonnances({Key? key, this.ordonnanceId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Étape 1: Utiliser l'ID de l'ordonnance passé en paramètre
    if (ordonnanceId == null) {
      // Si l'ID n'est pas disponible, peut-être afficher un indicateur de chargement
      return CircularProgressIndicator();
    }

    final OrdonnanceService _ordonnanceService = OrdonnanceService();

    return FutureBuilder<Ordonnance>(
      // Étape 2: Afficher un indicateur de chargement lorsque les données sont en cours de chargement
      future: _ordonnanceService.getOrdonnanceById(ordonnanceId!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Erreur : ${snapshot.error}');
        }

        final Ordonnance ordonnance = snapshot.data!;

        // Ajoutez ces lignes pour déboguer
        print('Données chargées avec succès');
        print('Ordre des appels : Avant le retour de Scaffold');

        return Scaffold(
          backgroundColor: Color(0xFFB2DFDB),
          appBar: AppBar(
            backgroundColor: Color(0xFFCB4354),
            automaticallyImplyLeading: true,
            title: Text(
              'Détails Ordonnances',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            actions: [],
            centerTitle: true,
            elevation: 4,
          ),
          body: Container(
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
                          'assets/images/img5.jpg', // Remplacez cela par le chemin de la photo de l'ordonnance
                          fit: BoxFit.cover,
                          height: 100,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(25),
                        child: Column(
                          children: [
                            Text(
                              "Type Ordonnance:${ordonnance.specialiteOrd}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text('Nom Medecin : ${ordonnance.nomMedcin}', textAlign: TextAlign.center),
                            Text('Phone medecin : ${ordonnance.phoneMedcin}', textAlign: TextAlign.center),
                            Text('Date Ordonnance : ${ordonnance.datePrescription}', textAlign: TextAlign.center),
                            Text('Nom Patient : ${ordonnance.nomPatient}', textAlign: TextAlign.center),
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
                          Navigator.pop(context); // Retour à l'écran précédent
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
      },
    );
  }
}
