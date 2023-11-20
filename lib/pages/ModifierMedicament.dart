import 'dart:io';

import 'package:flutter/material.dart';
import 'package:minipharma/models/Medicament.dart';
import 'package:minipharma/services/MedicamentService.dart';

class ModifierMedicamentWidget extends StatefulWidget {
  const ModifierMedicamentWidget({Key? key}) : super(key: key);

  @override
  _ModifierMedicamentWidgetState createState() =>
      _ModifierMedicamentWidgetState();
}

class _ModifierMedicamentWidgetState extends State<ModifierMedicamentWidget> {
  final MedicamentService _medicamentService = MedicamentService();
  late Future<Medicament> _medicamentFuture;
final TextEditingController _quantiteController = TextEditingController();
  final TextEditingController _prixController = TextEditingController();
  final TextEditingController _formeController = TextEditingController();
  final TextEditingController _posologieController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _dateDebutController = TextEditingController();
  final TextEditingController _dateExpController = TextEditingController();
  final TextEditingController _dureeTraitementController = TextEditingController();
  final TextEditingController _noteMedController = TextEditingController();
  final TextEditingController _prescriptionRequiseController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
   File? _image;
  late int medicamentId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    medicamentId = arguments['medicamentId'];
    _medicamentFuture = _medicamentService.getMedicamentById(medicamentId);
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB2DFDB),
      appBar: AppBar(
        backgroundColor: Color(0xFFCB4354),
        title: Text('Modifier le médicament'),
      ),
      body: Center(
        child: Container(
          width: 300,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: FutureBuilder<Medicament>(
            future: _medicamentFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Erreur: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return Center(child: Text('Aucune donnée trouvée.'));
              } else {
                _nomController.text = snapshot.data!.nomMed;
                _quantiteController.text = snapshot.data!.quantite.toString();
                _prixController.text = snapshot.data!.prix.toString();
                _formeController.text = snapshot.data!.forme;
                _posologieController.text = snapshot.data!.posologie;
                _typeController.text = snapshot.data!.type;
                _dateDebutController.text = snapshot.data!.dateDebut.toString();
                _dateExpController.text = snapshot.data!.dateExp.toString();
                _dureeTraitementController.text =
                    snapshot.data!.dureeTraitement;
                _noteMedController.text = snapshot.data!.noteMed;
                /*_prescriptionRequiseController.text =
                    snapshot.data!.prescriptionRequise.toString();*/

                return _buildEditForm(snapshot.data!);
              }
            },
          ),
        ),
      ),
    );
  }

    @override
Widget _buildEditForm(Medicament medicament) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _nomController,
          decoration: InputDecoration(labelText: 'Nom du médicament'),
        ),
        SizedBox(height: 15),
        _buildTextField(_quantiteController, 'Quantité'),
        SizedBox(height: 15),
        _buildTextField(_prixController, 'Prix'),
        SizedBox(height: 15),
        _buildTextField(_formeController, 'Forme'),
        SizedBox(height: 15),
        _buildTextField(_posologieController, 'Posologie'),
        SizedBox(height: 15),
        _buildTextField(_typeController, 'Type'),
        SizedBox(height: 15),
       
                    TextButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: parseDate(_dateDebutController.text),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );

                        if (pickedDate != null) {
                          setState(() {
                            _dateDebutController.text = formatDate(pickedDate);
                          });
                        }
                      },
                      child: Text(
                        'Date de Debut: ${_dateDebutController.text}',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                     SizedBox(height: 15),
       
                    TextButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: parseDate(_dateExpController.text),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );

                        if (pickedDate != null) {
                          setState(() {
                            _dateExpController.text = formatDate(pickedDate);
                          });
                        }
                      },
                      child: Text(
                        'Date d\'expiration: ${_dateExpController.text}',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    )
,
       
        SizedBox(height: 15),
        _buildTextField(
            _dureeTraitementController, 'Durée du traitement'),
        SizedBox(height: 15),
        _buildTextField(_noteMedController, 'Note médicament'),
        SizedBox(height: 15),
      /*  _buildTextField(
            _prescriptionRequiseController, 'Prescription requise'),
        SizedBox(height: 15),*/
        ElevatedButton(
          onPressed: () => _updateMedicament(medicament.id),
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFCB4354),
            onPrimary: Colors.white,
          ),
          child: Text('Valider'),
        ),
      ],
    ),
  );
}

Widget _buildTextField(TextEditingController controller, String labelText) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(labelText: labelText),
  );
}
  void _updateMedicament(int medicamentId) {
    Medicament updatedMedicament = Medicament(
      id: medicamentId,
      nomMed: _nomController.text,
      photo: _image?.path,
      quantite: int.parse(_quantiteController.text),
      prix: double.parse(_prixController.text),
      forme: _formeController.text,
      posologie: _posologieController.text,
      type: _typeController.text,
       dateDebut: parseDate(_dateDebutController.text),
      dateExp:  parseDate(_dateDebutController.text),
      dureeTraitement: _dureeTraitementController.text,
      noteMed: _noteMedController.text,
    );

    _medicamentService.updateMedicament(medicamentId, updatedMedicament);

    Navigator.pop(context);
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
