import 'package:flutter/material.dart';
import 'package:minipharma/models/Ordonnance.dart';
import 'package:minipharma/pages/ListOrd.dart';
import '../models/Medicament.dart';
import '../Services/MedicamentService.dart';
import '../Services/OrdonnanceService.dart';

class AjouterOrdWidget extends StatefulWidget {
  const AjouterOrdWidget({Key? key}) : super(key: key);

  @override
  _AjouterOrdWidgetState createState() => _AjouterOrdWidgetState();
}

class _AjouterOrdWidgetState extends State<AjouterOrdWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController id = TextEditingController();
  TextEditingController nomMedecinController = TextEditingController();
  TextEditingController datePrescriptionController = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController specialiteController = TextEditingController();
  TextEditingController nomPatientController = TextEditingController();
  List<Medicament> medicaments = [];
  List<Medicament> selectedMedicaments = [];

  @override
  void initState() {
    super.initState();
    MedicamentService().getAllMedicaments().then((medicamentList) {
      setState(() {
        medicaments = medicamentList;
      });
    }).catchError((error) {
      print('Error fetching medications: $error');
      // Handle the error as needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFFCB4354),
          automaticallyImplyLeading: true,
          title: Text(
            'Ajouter Ordonnance',
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
        body: Stack(
          children: [
            Center(
              child: Container(
                width: 250,
                child: SingleChildScrollView(
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
                      SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );

                          if (pickedDate != null && pickedDate != datePrescriptionController) {
                            setState(() {
                              datePrescriptionController.text = pickedDate.toString();
                            });
                          }
                        },
                        child: Text(
                          'Date Prescription',

                          style: TextStyle(
                            color: Colors.black,

                          ),

                        ),
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        controller: dosageController,
                        decoration: InputDecoration(
                          labelText: 'Dosage',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: 'Téléphone Medecin',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        controller: specialiteController,
                        decoration: InputDecoration(
                          labelText: 'Spécialité Medecin',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        controller: nomPatientController,
                        decoration: InputDecoration(
                          labelText: 'Nom Patient',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Column(
                        children: medicaments.map((medicament) {
                          return CheckboxListTile(
                            title: Text(medicament.nomMed),
                            value: selectedMedicaments.contains(medicament),
                            onChanged: (bool? value) {
                              setState(() {
                                if (value != null) {
                                  if (value) {
                                    selectedMedicaments.add(medicament);
                                  } else {
                                    selectedMedicaments.remove(medicament);
                                  }
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),

                    
                      ElevatedButton.icon(
                        onPressed: () {
                          print('Button pressed ...');
                          print('Nom Medecin: ${nomMedecinController.text}');
                          print('Date Prescription: ${datePrescriptionController.text}');
                          print('Dosage: ${dosageController.text}');
                          print('Phone: ${phoneController.text}');
                          print('Phone: ${specialiteController.text}');
                          print('Phone: ${nomPatientController.text}');
                          print('Medicaments sélectionnés: $selectedMedicaments');

                          Ordonnance nouvelleOrdonnance = Ordonnance(
                            idOrd: id.hashCode,
                            nomMedcin: nomMedecinController.text,
                            datePrescription: parseDate(datePrescriptionController.text),
                            medicaments: selectedMedicaments, // Assign the list directly
                            phoneMedcin: phoneController.text,
                            specialiteOrd: specialiteController.text,
                            nomPatient: nomPatientController.text,
                            photoOrdonnance: '',
                          );

                          OrdonnanceService().createOrdonnance(nouvelleOrdonnance).then((ordonnance) {
                            print('Ordonnance ajoutée avec succès: ${ordonnance.idOrd}');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListOrd(specialite: specialiteController.text),
                              ),
                            );
                          }).catchError((error) {
                            print('Erreur lors de l\'ajout de l\'ordonnance: $error');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListOrd(specialite: specialiteController.text),
                              ),
                            );
                          });
                        },
                        label: Text(
                          'Ajouter Ordonnance',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        icon: Icon(Icons.add, size: 24, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFCB4354),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DateTime parseDate(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      print('Erreur lors de la conversion de la date: $e');
      return DateTime.now();
    }
  }
}
