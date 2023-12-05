import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minipharma/Models/Rappel.dart';
import 'package:minipharma/Services/NotifService.dart';
import 'package:minipharma/Services/notifications_services.dart';
import 'package:minipharma/pages/notifs.dart';


class AddHeureWidget extends StatefulWidget {
  const AddHeureWidget({Key? key}) : super(key: key);

  @override
  _AddHeureWidgetState createState() => _AddHeureWidgetState();
}

class _AddHeureWidgetState extends State<AddHeureWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _heureRappelController = TextEditingController();
  final TextEditingController _dureeTraitementEnJoursController = TextEditingController();

  
  final NotifService _rappelService = NotifService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFCB4354),
        title: Text(
          'Ajouter heure de rappel d\'un medicament',
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
                _buildTextField('Nom Médicament', _nomController),
                _buildTextField(
                  'durée de traitement',
                  _dureeTraitementEnJoursController,
                  keyboardType: TextInputType.number,
                ),
               
                SizedBox(height: 25),
                _buildSelectedDate('Heure de  Rappel', _heureRappelController),
                
              
                
              
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    _ajouterRappel();
                    Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => NotifsWidget(), // Assurez-vous que le nom de la classe est correct
  ),
);

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

          if (pickedDate != null) {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              builder: (BuildContext context, Widget? child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                  child: child!,
                );
              },
            );

            if (pickedTime != null) {
              DateTime selectedDateTime = DateTime(
                pickedDate.year,
                pickedDate.month,
                pickedDate.day,
                pickedTime.hour,
                pickedTime.minute,
              );

              setState(() {
                controller.text = DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime);
              });
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orange),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              controller.text.isNotEmpty
                  ? DateFormat('yyyy-MM-dd HH:mm').format(parseDate(controller.text))
                  : 'Sélectionnez l\'heure',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
      if (controller.text.isEmpty)
        Text(
          'Veuillez sélectionner l\'heure',
          style: TextStyle(
            color: Colors.red,
            fontSize: 12,
          ),
        ),
      SizedBox(height: 15),
    ],
  );
}


Future<void> _ajouterRappel() async {
  String nom = _nomController.text;
  int dureeTraitementEnJours = int.tryParse(_dureeTraitementEnJoursController.text) ?? 0;
  DateTime heureRappel = parseDate(_heureRappelController.text).add(Duration(hours: 2));

  try {
    if (nom.isNotEmpty && dureeTraitementEnJours > 0 && _heureRappelController.text.isNotEmpty) {
      MedicamentRappel newRappel = MedicamentRappel(
        id: 0,
        nom: nom,
        dureeTraitementEnJours: dureeTraitementEnJours,
        heureRappel: heureRappel..toUtc(),
        color: 0,
        isCompleted: 0,
      );

      print(heureRappel);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Rappel ajouté avec succès!'),
          ),
        );
        Navigator.pop(context);
      }

      _nomController.clear();
      _dureeTraitementEnJoursController.clear();
      _heureRappelController.clear();
      await _rappelService.createRappel(newRappel);

      NotificationServices().scheduleNotification(
        id: newRappel.id,
        title: 'Votre médicament ${newRappel.nom}',
        body: 'Il est temps de prendre votre médicament!',
        scheduledNotificationDateTime: newRappel.heureRappel,
      );
      print(heureRappel);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Veuillez remplir tous les champs correctement et vérifier les dates.'),
          ),
        );
      }
    }
  } catch (e) {
    print('Erreur lors de l\'ajout du rappel : $e');
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de l\'ajout du rappel. Veuillez réessayer.'),
        ),
      );
    }
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

  

