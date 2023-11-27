import 'package:flutter/material.dart';

class AjouterDiagnostic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                Icons.add,
                size: 25,
                color: Color(0xFF4C53A5),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Ajouter Diagnostic",
                  style: TextStyle(
                    fontSize: 19,
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
                    size: 25,
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
          // width: 250,
          width: screenWidth * 0.8,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nom de la maladie
              Text(
                'Nom de la maladie',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8), // Espacement
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Introduire le nom de la maladie',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              SizedBox(height: 15),

              // Date de diagnostic
              Text(
                'Date de diagnostic',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Introduire la date',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              SizedBox(height: 10),

              // Catégorie
              Text(
                'Catégorie',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: MediaQuery.of(context)
                    .size
                    .width, // Set width to screen width
                child: DropdownButton<String>(
                  isExpanded:
                      true, // Make the dropdown button expand to the full width
                  items: ['Clinique', 'Radiologique', 'Biologique']
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
                      color: Colors.grey, // Adjust the color of the hint text
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Description du diagnostic
              Text(
                'Description du diagnostic',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Description du diagnostic',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              SizedBox(height: 10),

              // Commentaires
              Text(
                'Commentaires',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Commentaires',
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
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        // Add your logic for the 'Ajouter' button here
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent, // Set the background color
                        onPrimary: Colors.white, // Set the text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              5.0), // Set border radius here
                          side: BorderSide(
                              color: Colors.redAccent), // Set border color here
                        ),
                      ),
                    ),
                  
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
