import 'dart:io';

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../models/Bilan.dart';
import '../Services/BilanService.dart';

/*class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Bilan',
      debugShowCheckedModeBanner: false,
      home: BilanListPage(),
    );
  }
}
*/
class BilanListPage extends StatefulWidget {
  const BilanListPage({Key? key}) : super(key: key);

  @override
  State<BilanListPage> createState() => _BilanListPageState();
}

class _BilanListPageState extends State<BilanListPage> {
  final List<String> categories = ['Clinique', 'Radiologique', 'Biologique'];
  final BilanService _bilanService = BilanService();


  List<String> selectedCategories = [];
  // List<Bilan> diagnosticList = [];

  List<Bilan> diagnosticList=[] ;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

 Future<void> _loadData() async {
  try {
    List<Bilan> bilans = await _bilanService.getAllBilan();
    setState(() {
     diagnosticList = bilans;
    });
   } catch (e) {
     print('Error loading data: $e');
   }
 }
 Future<void> _deleteBilan(int id) async {
    try {
      print('from list ${id}');
      await _bilanService.deleteBilan(id);

    /*  setState(() async {
         List<Bilan> bilans = await  _bilanService.getAllBilan();
      });*/
    } catch (e) {
      print('Erreur lors de la suppression du bilan : $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          color: Colors.white,
          padding: EdgeInsets.all(25),
          child: Row(
            children: [
              Icon(
                Icons.qr_code,
                size: 30,
                color: Color(0xFF4C53A5),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Liste Bilan",
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
                  onTap: () {
                    Navigator.pushNamed(context, "/ajouterbilan");
                  },
                  child: Icon(
                    Icons.add_box,
                    size: 30,
                    color: Color(0xFF4C53A5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      
      body: Column(
        
        children: [
          SizedBox(height: 20,),
          Container(
            
            margin: EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 50,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 216, 213, 213),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5),
                  height: 50,
                  width: 260,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search here",
                    ),
                  ),
                ),
                Icon(
                  Icons.camera_alt,
                  size: 27,
                  color: Color(0xFF4C53A5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: categories
                  .map((category) => FilterChip(
                selected: selectedCategories.contains(category),
                label: Text(category),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      selectedCategories.add(category);
                    } else {
                      selectedCategories.remove(category);
                    }
                  });
                },
              ))
                  .toList(),
            ),
          ),

          //ItemWidget
          Expanded(
            child: ListView.builder(
              itemCount: diagnosticList.length,
              itemBuilder: (context, index) {
                final product = diagnosticList[index];
                return InkWell(
                  onTap: () {
                    // Navigate to the details page or handle the tap event.
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 2.0,
                      margin: const EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                       Expanded(
  child: Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      product.image != null
        ? Image.file(
            File(product.image!),
            height: 100, // Adjust the height as needed
            width: 100,  // Adjust the width as needed
          )
        : Container(),
    ],
  ),
),
                            SizedBox(width: 20.0),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 50.0), // Adjust the top margin as needed
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Nom: ${product.nomMedcin}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    SizedBox(height: 15.0),
                                    Text(
                                      'Spécialité: ${product.specialite}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    SizedBox(height: 20.0),
                                    Text(
                                      'Résultat: ${product.resultat}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    SizedBox(height: 16.0),
                                  ],
                                ),
                              ),
                            ),



                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildIconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      "/modifierbilan",
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  label: 'Edit',
                                  color: Colors.blue,
                                ),
                              
                             InkWell(
  onTap: () {
    if (product.id != null) {
      _deleteBilan(product.id!);
      print('${product.id}');
    }
  },
  child: Icon(
    Icons.delete,
    color: Colors.amber,
  ),
),

                                
                                buildIconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      "/detailsBilan",
                                    );
                                  },
                                  icon: Icon(
                                    Icons.info,
                                    color: Colors.green,
                                  ),
                                  label: 'Details',
                                  color: Colors.green,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: const Color(0xFFCB4354),
        items: const <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.notifications,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home2'); // Accueil
              break;
            case 1:
              Navigator.pushNamed(context, '/notifs'); // Notifications
              break;
            case 2:
              Navigator.pushNamed(context, '/profile'); // Profil
              break;
          }
        },
      ),
    );
  }

  Widget buildIconButton({
    required VoidCallback onPressed,
    required Icon icon,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: icon,
          color: color,
        ),
        Text(
          label,
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}










/*import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:minipharma/widgets/ItemWidgetsBilan.dart';
//import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../widgets/ItemWidget.dart';
import '../widgets/ListMedAppBar.dart';

class ListBilan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        ListMedAppBar(),
        Container(
          //height: 500,
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Color(0xFFB2DFDB),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35)),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        height: 50,
                        width: 260,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search here",
                          ),
                        ),
                      ),
                      Icon(
                        Icons.camera_alt,
                        size: 27,
                        color: Color(0xFF4C53A5),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 30,
                  ),
                  child: Column(
                    children: [

                      ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),

                        ),

                        onPressed: () {
                          Navigator.pushNamed(context, "/ajoutermed");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              size: 27,
                            ),
                            SizedBox(width: 8),
                            Text("Ajouter Medicament", style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),),
                          ],
                        ),

                      ),

                      /*  Text(
                        "Tous les medicaments",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),*/
                    ],
                  ),
                ),

                ItemWidgetsBilan(),
              ],
            )),
      ]),
      /*  bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Color(0xFF4C53A5),
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.notifications,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.face,
            size: 30,
            color: Colors.white,
          ),

        ],
        onTap: (index) {
          // GÃ©rez ici le changement d'onglet
        },
      ),*/
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Color(0xFFCB4354),
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.notifications,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),

        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home2'); // Accueil
              break;
            case 1:
              Navigator.pushNamed(context, '/notifs'); // Notifications
              break;
            case 2:
              Navigator.pushNamed(context, '/profile'); // Profil
              break;
          }
        },
      ),
    );
  }
}*/