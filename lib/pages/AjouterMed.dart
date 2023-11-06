
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AjouterMedWidget extends StatefulWidget {
  const AjouterMedWidget({Key? key}) : super(key: key);

  @override
  _AjouterMedWidgetState createState() => _AjouterMedWidgetState();
}

class _AjouterMedWidgetState extends State<AjouterMedWidget> {


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
        backgroundColor:Color(0xFFB2DFDB),
        appBar: AppBar(
          backgroundColor: Color(0xFFCB4354),
          automaticallyImplyLeading: true,
          title: Text(
            'Ajouter Medicament',
            style:TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 4,
        ),
        body: Center(
          child: Container(
            width: 250, // Largeur de 250 pixels
            padding: EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nom Médicament',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Introduire le nom',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange), // Couleur de la bordure orange
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Quantité',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Introduire la quantité',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange), // Couleur de la bordure orange
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Date Début',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Introduire la date de début',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange), // Couleur de la bordure orange
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Date d\'expiration',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Introduire la date d\'expiration',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange), // Couleur de la bordure orange
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Catégorie',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButton<String>(
                  items: ['Anti-inflammatoires', 'Antibiotiques', 'Cardiologie', 'Dermatologie']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                  hint: Text('Sélectionnez une catégorie',
                    style: TextStyle(
                    fontSize: 14),
                ),),
                SizedBox(height: 10),

                // Élément "Importer Image"
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Logique pour le bouton d'import
                      },
                      child:  Text(
                        ' Importer une image',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color:Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.image, // Utilisez l'icône d'image
                      color: Colors.black, // Couleur d'icône, remplacez par votre préférée
                      size: 70,
                    ),
                  ],
                ),


                // Bouton "Ajouter" centré à la base
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child:ElevatedButton(
                      onPressed: () {
                        // Logique pour ajouter le médicament
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width:5), // Espacement entre l'icône et le texte
                          Text('Ajouter', style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          )),
                          Icon(
                            Icons.sentiment_satisfied, // Icône smile souriant
                            size: 24,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFFCB4354)),
                      ),
                    )

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
