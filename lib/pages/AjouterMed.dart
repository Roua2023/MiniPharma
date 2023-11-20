import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minipharma/models/Medicament.dart';
import 'dart:io';

import 'package:minipharma/services/MedicamentService.dart';

class AjouterMedWidget extends StatefulWidget {
  const AjouterMedWidget({Key? key}) : super(key: key);

  @override
  _AjouterMedWidgetState createState() => _AjouterMedWidgetState();
}

class _AjouterMedWidgetState extends State<AjouterMedWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _nomMedController = TextEditingController();
  final TextEditingController _quantiteController = TextEditingController();
  final TextEditingController _prixController = TextEditingController();
  final TextEditingController _formeController = TextEditingController();
  final TextEditingController _posologieController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _dureeController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _photoController = TextEditingController();
  final TextEditingController _dateExpController = TextEditingController();
  final TextEditingController _dateDebutController = TextEditingController();

  File? _image;
  final MedicamentService _medicamentService = MedicamentService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFCB4354),
        title: Text(
          'Ajouter Medicament',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body:SingleChildScrollView(
        child: Center(
          child: Container(
            width: 250,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField('Nom Médicament', _nomMedController),
                _buildTextField(
                  'Quantité',
                  _quantiteController,
                  keyboardType: TextInputType.number,
                ),
                _buildTextField(
                  'Prix',
                  _prixController,
                  keyboardType: TextInputType.number,
                ),
                _buildTextField('Forme', _formeController),
                _buildTextField('Posologie', _posologieController),
                _buildTextField('Type', _typeController),
                _buildTextField('Durée de Traitement', _dureeController),
                _buildTextField('Note Médicament', _noteController),
                SizedBox(height: 15),
                _buildSelectedDate('Date Début', _dateDebutController),
                SizedBox(height: 25),
                _buildSelectedDate('Date Expiration', _dateExpController),
                SizedBox(height: 20),
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
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    _ajouterMedicament();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 5),
                      Icon(
                        Icons.add,
                        size: 24,
                        color: Colors.white,
                      ),
                      Text(
                        'Ajouter',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFFCB4354)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller,
      {TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: 'Introduire $labelText',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
            ),
            contentPadding: EdgeInsets.all(10),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  Widget _buildSelectedDate(String labelText, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );

            if (pickedDate != null && pickedDate != controller) {
              setState(() {
                controller.text = pickedDate.toString();
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.orange),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                controller.text,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      try {
        String imageUrl = (await _medicamentService.uploadFile(File(pickedImage.path))) as String;
        setState(() {
          _photoController.text = imageUrl;
          _image = File(pickedImage.path);
        });
      } catch (e) {
        print('Error uploading/retrieving the image URL: $e');
      }
    }
  }

  Future<void> _ajouterMedicament() async {
    String nomMed = _nomMedController.text;
    int quantite = int.tryParse(_quantiteController.text) ?? 0;
    double prix = double.tryParse(_prixController.text) ?? 0.0;
    String forme = _formeController.text;
    String posologie = _posologieController.text;
    String type = _typeController.text;
    String dureeTraitement = _dureeController.text;
    String noteMed = _noteController.text;
    DateTime dateDebut = parseDate(_dateDebutController.text);
    DateTime dateExp = parseDate(_dateExpController.text);

    try {
      if (nomMed.isNotEmpty &&
          quantite > 0 &&
          prix > 0 &&
          _dateDebutController.text.isNotEmpty &&
          _dateExpController.text.isNotEmpty &&
          dateDebut.isBefore(dateExp)) {
        if (_image != null) {
          await _medicamentService.uploadFile(_image!);
          _photoController.text = _image!.path;
        }

        Medicament newMedicament = Medicament(
          id: 0,
          nomMed: nomMed,
          photo: _photoController.text.toString(),
          quantite: quantite,
          prix: prix,
          forme: forme,
          posologie: posologie,
          type: type,
          dateDebut: dateDebut,
          dateExp: dateExp,
          dureeTraitement: dureeTraitement,
          noteMed: noteMed,
        );

        

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Médicament ajouté avec succès!'),
          ),
        );
        Navigator.pop(context);

        _nomMedController.clear();
        _quantiteController.clear();
        _prixController.clear();
        _formeController.clear();
        _posologieController.clear();
        _typeController.clear();
        _dureeController.clear();
        _noteController.clear();
await _medicamentService.createMedicament(newMedicament);
        setState(() {
          _image = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Veuillez remplir tous les champs correctement et vérifier les dates.'),
          ),
        );
      }
    } catch (e) {
      print('Erreur lors de l\'ajout du médicament : $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de l\'ajout du médicament. Veuillez réessayer.'),
        ),
      );
    }
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
