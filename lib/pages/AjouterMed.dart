import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AjouterMedWidget extends StatefulWidget {
  const AjouterMedWidget({Key? key}) : super(key: key);

  @override
  _AjouterMedWidgetState createState() => _AjouterMedWidgetState();
}

class _AjouterMedWidgetState extends State<AjouterMedWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  File? _image;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFB2DFDB),
      appBar: AppBar(
        backgroundColor: Color(0xFFCB4354),
        automaticallyImplyLeading: true,
        title: Text(
          'Ajouter Medicament',
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
      body: Center(
        child: Container(
          width: 250,
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
                    borderSide: BorderSide(color: Colors.orange),
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
                    borderSide: BorderSide(color: Colors.orange),
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
                    borderSide: BorderSide(color: Colors.orange),
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
                    borderSide: BorderSide(color: Colors.orange),
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
                hint: Text(
                  'Sélectionnez une catégorie',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 10),
              _image != null
                  ? Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      pickImage();
                    },
                    child: Icon(
                      Icons.image_outlined,
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 100, // Ajustez la largeur à votre convenance
                    height: 150, // Ajustez la hauteur à votre convenance
                    child: Image.file(
                      _image!,
                      fit: BoxFit.cover, // Ajustez le mode d'ajustement de l'image
                    ),
                  )
                ],
              )
                  : Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      pickImage();
                    },
                    child: Icon(
                      Icons.image_outlined,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      // Logique pour ajouter le médicament
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 5),
                        Text(
                          'Ajouter',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.sentiment_satisfied,
                          size: 24,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFFCB4354)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }
}
