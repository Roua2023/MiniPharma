import 'dart:io';
import 'package:flutter/material.dart';
import 'package:minipharma/Services/MedicamentService.dart';
import 'package:minipharma/models/Medicament.dart';

class ItemWidget extends StatefulWidget {
  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  late Future<List<Medicament>> _medicamentsFuture;
  final MedicamentService _medicamentService = MedicamentService();

  @override
  void initState() {
    super.initState();
    _medicamentsFuture = _medicamentService.getAllMedicaments();
  }

  Future<void> _deleteMedicament(int id) async {
    try {
      await _medicamentService.deleteMedicament(id);
      setState(() {
        _medicamentsFuture = _medicamentService.getAllMedicaments();
      });
    } catch (e) {
      print('Erreur lors de la suppression du médicament : $e');
    }
  }

  Widget _buildMedicamentItem(Medicament medicament) {
  return Container(
    padding: EdgeInsets.only(left: 10, right: 10, top: 15), // Ajustement ici
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    height: 180,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.medical_services,
              color: Colors.red,
            ),
          ],
        ),
        InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.all(10),
          child: Row(
  mainAxisSize: MainAxisSize.max,
  children: [
    medicament.photo != null
      ? Image.file(
          File(medicament.photo!),
          height: 60, // Essayez une valeur plus grande
          width: 60,  // Essayez une valeur plus grande
        )
      : Container(),
  ],
),

          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 8),
          alignment: Alignment.centerLeft,
          child: Text(
            medicament.nomMed,
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF4C53A5),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          child: Text(
            'Prix: ${medicament.prix}',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF4C53A5),
            ),
          ),
        ),
        Container(
          child: Text(
            'Date d\'expiration: ${medicament.dateExp}',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF4C53A5),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded( // Ajout de Expanded ici
                child: Text(
                  "${medicament.quantite} QTE",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C53A5),
                  ),
                ),
              ),
              InkWell(
                onTap: () => _deleteMedicament(medicament.id!),
                child: Icon(
                  Icons.delete,
                  color: Colors.amber,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    "/modifiermed",
                    arguments: {"medicamentId": medicament.id},
                  );
                },
                child: Icon(
                  Icons.update_sharp,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Medicament>>(
      future: _medicamentsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Aucun médicament trouvé.'));
        } else {
          return GridView.count(
            childAspectRatio: 0.68,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            shrinkWrap: true,
            children: [
              for (int i = 0; i < snapshot.data!.length; i++)
                _buildMedicamentItem(snapshot.data![i]),
            ],
          );
        }
      },
    );
  }
}
