import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minipharma/Services/OrdonnanceService.dart';
import 'package:minipharma/models/Ordonnance.dart';
import 'package:minipharma/pages/ListOrd.dart';



class AjouterOrdWidget extends StatefulWidget {
  const AjouterOrdWidget({Key? key}) : super(key: key);

  @override
  _AjouterOrdWidgetState createState() => _AjouterOrdWidgetState();
}

class _AjouterOrdWidgetState extends State<AjouterOrdWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController nomMedecinController = TextEditingController();
  TextEditingController datePrescriptionController = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController specialiteController = TextEditingController();
  TextEditingController nomPatientController = TextEditingController();
  TextEditingController medicamentController = TextEditingController();
  TextEditingController OrdonnancePhotoController=TextEditingController();
  List<String> selectedMedicaments = [];
  File? _image;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nomMedecinController,
                decoration: InputDecoration(
                  labelText: 'Nom du Médecin',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nom du médecin';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null &&
                      pickedDate != datePrescriptionController) {
                    setState(() {
                      datePrescriptionController.text =
                          pickedDate.toString();
                    });
                  }
                },
                icon: Icon(Icons.calendar_today),
                label: Text('Sélectionner la date de prescription'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFCB4354),
                  textStyle: TextStyle(fontSize: 14),
                ),
              ),
              SizedBox(height: 10),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le dosage';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Téléphone du Médecin',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le numéro de téléphone du médecin';
                  }
                  if (!isNumeric(value)) {
                    return 'Le numéro de téléphone doit contenir uniquement des chiffres';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: specialiteController,
                decoration: InputDecoration(
                  labelText: 'Spécialité du Médecin',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la spécialité du médecin';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nom du patient';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: medicamentController,
                decoration: InputDecoration(
                  labelText: 'Nom du Médicament',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                    ),
                  ),
                ),
                /*validator: (selectedMedicaments) {
                  if ( selectedMedicaments!.isEmpty==false) {
                    return 'Veuillez entrer le nom du médicament';
                  }
                  return null;
                },*/
              ),
                            SizedBox(height: 5),

              Row(
                  //mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: 50,
                      child: _image != null
                          ? Image.file(_image!)
                          : Container(),
                    ),
                  ],
                ),
                 SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _pickImage(ImageSource.gallery);
                        },
                        child: Column(
                          children: [
                            Icon(Icons.photo, size: 30),
                            Text("Choisir de la galerie"),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _pickImage(ImageSource.camera);
                        },
                        child: Column(
                          children: [
                            Icon(Icons.camera_alt, size: 30),
                            Text("Prendre une photo"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedMedicaments.add(medicamentController.text);
                    medicamentController.clear();
                  });
                },
                child: Text('Ajouter Médicament'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFCB4354),
                ),
              ),
              SizedBox(height: 10),
              Text('Médicaments Sélectionnés:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Column(
                children: selectedMedicaments
                    .map((medicament) => Text(medicament))
                    .toList(),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                 _ajouterOrdonnance();
                },
                label: Text('Ajouter Ordonnance'),
                icon: Icon(Icons.add, size: 24, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFCB4354),
                ),
              ),
            ],
          ),
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

  bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }
   Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      try {
        String imageUrl = (await OrdonnanceService().uploadFile(File(pickedImage.path)));
        setState(() {
          OrdonnancePhotoController.text = imageUrl;
          _image = File(pickedImage.path);
        });
      } catch (e) {
        print('Error uploading/retrieving the image URL: $e');
      }
    }
  }

   Future<void> _ajouterOrdonnance() async {
 if (_formKey.currentState?.validate() ?? false) {

   if (_image != null) {
          await OrdonnanceService().uploadFile(_image!);
          OrdonnancePhotoController.text = _image!.path;
        }
                    Ordonnance nouvelleOrdonnance = Ordonnance(
                      idOrd: nomMedecinController.text.hashCode,
                      nomMedcin: nomMedecinController.text,
                      datePrescription:
                      parseDate(datePrescriptionController.text),
                      phoneMedcin: phoneController.text,
                      specialiteOrd: specialiteController.text,
                      nomPatient: nomPatientController.text,
                      photoOrdonnance: OrdonnancePhotoController.text.toString(),
                      medicaments: selectedMedicaments,
                    );

                    OrdonnanceService()
                        .createOrdonnance(nouvelleOrdonnance)
                        .then((ordonnance) {
                      print(
                          'Ordonnance ajoutée avec succès: ${ordonnance.idOrd}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ListOrd(specialite: specialiteController.text),
                        ),

                      );
                       setState(() {
          _image = null;
        });
                    }).catchError((error) {
                      print(
                          'Erreur lors de l\'ajout de l\'ordonnance: $error');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ListOrd(specialite: specialiteController.text),
                        ),
                      );
                    });
                  }
   }
}