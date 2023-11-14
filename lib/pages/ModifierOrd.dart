import 'package:flutter/material.dart';
import '../models/Ordonnance.dart';
import '../services/OrdonnanceService.dart';

class ModifierOrdWidget extends StatefulWidget {
  final int ordonnanceId;

  ModifierOrdWidget({required this.ordonnanceId});

  @override
  _ModifierOrdWidgetState createState() => _ModifierOrdWidgetState();
}

class _ModifierOrdWidgetState extends State<ModifierOrdWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController nomMedecinController = TextEditingController();
  TextEditingController datePrescriptionController = TextEditingController();
  TextEditingController phoneMedecinController = TextEditingController();
  TextEditingController specialiteMedecinController = TextEditingController();
  TextEditingController nomPatientController = TextEditingController();
  TextEditingController medicamentController = TextEditingController();
  TextEditingController photoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Modifier Ordonnance'),
        backgroundColor: Color(0xFFCB4354),
      ),
      body: FutureBuilder<Ordonnance>(
        future: OrdonnanceService().getOrdonnanceById(widget.ordonnanceId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Aucune donnée trouvée.'));
          } else {
            Ordonnance ordonnance = snapshot.data!;
            nomMedecinController.text = ordonnance.nomMedcin;
            datePrescriptionController.text = ordonnance.datePrescription.toString();
            phoneMedecinController.text = ordonnance.phoneMedcin;
            specialiteMedecinController.text = ordonnance.specialiteOrd;
            nomPatientController.text = ordonnance.nomPatient;
            medicamentController.text = ordonnance.medicaments.join(", ");
            photoController.text = ordonnance.photoOrdonnance;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(80,0,0,0),
              child: Container(
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                    ),
                    TextFormField(
                      controller: nomMedecinController,
                      decoration: InputDecoration(
                        labelText: 'Nom Medecin',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: parseDate(datePrescriptionController.text),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );

                        if (pickedDate != null) {
                          setState(() {
                            datePrescriptionController.text = formatDate(pickedDate);
                          });
                        }
                      },
                      child: Text(
                        'Date de Prescription: ${datePrescriptionController.text}',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    )
,
                    SizedBox(height: 16),
                    TextFormField(
                      controller: phoneMedecinController,
                      decoration: InputDecoration(
                        labelText: 'Téléphone du Médecin',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: specialiteMedecinController,
                      decoration: InputDecoration(
                        labelText: 'Spécialité du Médecin',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: nomPatientController,
                      decoration: InputDecoration(
                        labelText: 'Nom du Patient',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: medicamentController,
                      decoration: InputDecoration(
                        labelText: 'Médicament',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: photoController,
                      decoration: InputDecoration(
                        labelText: 'Photo de l\'Ordonnance',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Perform the update logic here
                        Ordonnance updatedOrdonnance = Ordonnance(
                          idOrd: ordonnance.idOrd,
                          nomMedcin: nomMedecinController.text,
                          datePrescription: parseDate(datePrescriptionController.text),
                          phoneMedcin: phoneMedecinController.text,
                          specialiteOrd: specialiteMedecinController.text,
                          nomPatient: nomPatientController.text,
                          photoOrdonnance: photoController.text,
                          // Convert the string of medicament names to a list
                          medicaments: [],
                        );

                        OrdonnanceService().updateOrdonnance(ordonnance.idOrd, updatedOrdonnance).then((updated) {
                          // Handle success, e.g., show a success message or navigate back
                          Navigator.pop(context);
                        }).catchError((error) {
                          // Handle error, e.g., show an error message
                          print('Erreur lors de la mise à jour de l\'ordonnance: $error');
                        });
                      },
                      child: Icon(Icons.edit_rounded, size: 24, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFCB4354),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  DateTime parseDate(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      // Handle parsing error, return a default value, or throw an exception
      print('Erreur lors de la conversion de la date: $e');
      return DateTime.now();
    }
  }

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

}
