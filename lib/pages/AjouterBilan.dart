import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minipharma/Services/BilanService.dart';
import 'package:minipharma/models/Bilan.dart';
import 'package:minipharma/pages/ListBilan.dart';



class AjouterBilan extends StatefulWidget {
  @override
  _AjouterBilanState createState() => _AjouterBilanState();
}

class _AjouterBilanState extends State<AjouterBilan> {
  
  final TextEditingController nomMedcinController = TextEditingController();
  final TextEditingController specialiteController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController resultatController = TextEditingController();

  final BilanService bilanService = BilanService();
File? _image;
  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    nomMedcinController.dispose();
    specialiteController.dispose();
    categoryController.dispose();
    imageController.dispose();
    resultatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Container(
          color: Colors.white,
          padding: EdgeInsets.all(25),
          child: Row(
            children: [
              Icon(
                Icons.add,
                size: 30,
                color: Color(0xFF4C53A5),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Ajouter Bilan",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C53A5),
                  ),
                ),
              ),
              Spacer(),
              Badge(
                backgroundColor: Colors.red,
                child: InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.person,
                    size: 30,
                    color: Color(0xFF4C53A5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: screenWidth * 0.8,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nom de medcin',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: nomMedcinController,
                decoration: InputDecoration(
                  hintText: 'Introduire le nom de medcin',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              SizedBox(height: 15),

              Text(
                'Specialité',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              TextFormField(
                controller: specialiteController,
                decoration: InputDecoration(
                  hintText: 'Introduire la specialité',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              // SizedBox(height: 10),

              /* Text(
                'Catégorie',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: DropdownButton<String>(
                  isExpanded: true,
                  items: ['Clinique', 'Radiologique', 'Biologique']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      categoryController.text = newValue ?? '';
                    });
                  },
                  hint: Text(
                    'Sélectionnez une catégorie',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),*/
              SizedBox(height: 20),

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

              Text(
                'Resultat',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: resultatController,
                keyboardType: TextInputType.multiline,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'Introduire resultat de bilan',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Icons.add),
                      label: Text(
                        'Ajouter',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        print('Ajouter button pressed');
                         if (_image != null)  {
          await bilanService.uploadFile(_image!);
          imageController.text = _image!.path;
        }
                        Bilan newBilan = Bilan(
            
                          nomMedcin: nomMedcinController.text,
                          specialite: specialiteController.text,  
                          image: imageController.text.toString(),
                          resultat: resultatController.text, id: null,
                        );
                        print(newBilan);

                        bilanService.createBilan(newBilan)
                            .then((createdBilan) {
                          print('Bilan created: $createdBilan');
                        }).catchError((error) {
                          print('Error creating Bilan: $error');
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BilanListPage(),
                          ),

                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.redAccent),
                        ),

                      ),

                    ),
                    // ElevatedButton.icon(
                    //   icon: Icon(Icons.arrow_back),
                    //   label: Text(
                    //     'Retour',
                    //     style: TextStyle(
                    //         fontSize: 24, fontWeight: FontWeight.bold),
                    //   ),
                    //   onPressed: () {
                    //     // Handle the 'Retour' button press
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     primary: Colors.redAccent,
                    //     onPrimary: Colors.white,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(5.0),
                    //       side: BorderSide(color: Colors.redAccent),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


   Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      try {
        String imageUrl = (await bilanService.uploadFile(File(pickedImage.path))) as String;
        setState(() {
          imageController.text = imageUrl;
          _image = File(pickedImage.path);
        });
      } catch (e) {
        print('Error uploading/retrieving the image URL: $e');
      }
    }
  }
}