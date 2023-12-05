import 'package:flutter/material.dart';
import '../services/MedicamentService.dart';
import '../models/Medicament.dart';

class DetailsMedicament extends StatelessWidget {
  final int? medicamentId;

  const DetailsMedicament({Key? key, this.medicamentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (medicamentId == null) {
      return CircularProgressIndicator();
    }

    final MedicamentService _medicamentService = MedicamentService();

    return FutureBuilder<Medicament>(
      future: _medicamentService.getMedicamentById(medicamentId!),
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

        final Medicament medicament = snapshot.data!;

        return Scaffold(
          backgroundColor: Color(0xFFB2DFDB),
          appBar: AppBar(
            backgroundColor: Color(0xFFCB4354),
            automaticallyImplyLeading: true,
            title: Text(
              'Détails Medicament',
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
                          'assets/images/img5.jpg', // Replace this with the path to the medicament's photo
                          fit: BoxFit.cover,
                          height: 100,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(25),
                        child: Column(
                          children: [
                            Text(
                              'Nom: ${medicament.nomMed}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text('Date expiration: ${medicament.dateExp}', textAlign: TextAlign.center),
                            Text('Type: ${medicament.type}', textAlign: TextAlign.center),
                            Text('Quantité: ${medicament.quantite}', textAlign: TextAlign.center),
                            Text('Forme: ${medicament.forme}', textAlign: TextAlign.center),
                            Text('Posologie: ${medicament.posologie}', textAlign: TextAlign.center),
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
                              // Action to perform when the "Edit" button is clicked.
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete_forever,
                              color: Colors.blue,
                              size: 24.0,
                            ),
                            onPressed: () {
                              // Action to perform when the "Delete" button is clicked.
                            },
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Navigate back to the previous screen
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
