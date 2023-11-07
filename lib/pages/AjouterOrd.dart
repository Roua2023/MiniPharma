import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AjouterOrdWidget extends StatefulWidget {
  const AjouterOrdWidget({Key? key}) : super(key: key);

  @override
  _AjouterOrdWidgetState createState() => _AjouterOrdWidgetState();
}

class _AjouterOrdWidgetState extends State<AjouterOrdWidget> {
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
                        controller: TextEditingController(),
                        decoration: InputDecoration(
                          labelText: 'Nom Medecin',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  Colors.orange, // Couleur de la bordure orange
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        controller: TextEditingController(),
                        decoration: InputDecoration(
                          labelText: 'Date Prescription',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  Colors.orange, // Couleur de la bordure orange
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        controller: TextEditingController(),
                        decoration: InputDecoration(
                          labelText: 'Dosage',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  Colors.orange, // Couleur de la bordure orange
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        controller: TextEditingController(),
                        decoration: InputDecoration(
                          labelText: 'Etat',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  Colors.orange, // Couleur de la bordure orange
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      DropdownButton<String>(
                        items: ['DOLIPRANE', 'EFFERALGAN', 'SPASFON', 'IMODIUM']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {},
                        hint: Text(
                          'Sélectionnez des medicaments',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(height: 25),
                      ElevatedButton.icon(
                        onPressed: () {
                          print('Button pressed ...');
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
                          backgroundColor:
                              Color(0xFFCB4354), // Couleur du bouton orange
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
}
