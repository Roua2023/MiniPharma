import 'package:flutter/material.dart';
import 'package:minipharma/Services/OrdonnanceService.dart';
import 'package:minipharma/pages/ModifierOrd.dart';
import '../main.dart';
import '../models/Ordonnance.dart';
import '../pages/DetailsOrds.dart';

class ItemWidgetOrd extends StatefulWidget {
  final String specialite;

  const ItemWidgetOrd({Key? key, required this.specialite}) : super(key: key);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}


class _ItemWidgetState extends State<ItemWidgetOrd> {
  late Future<List<Ordonnance>> _ordonnancesFuture;
  final OrdonnanceService _ordonnanceservice = OrdonnanceService();

  @override
  void initState() {
    super.initState();
    _ordonnancesFuture = _ordonnanceservice.getOrdonnancesBySpecialite(widget.specialite);
  }


  Future<void> _deleteOrdonnance(int id) async {
    try {
      await _ordonnanceservice.deleteOrdonnance(id);
      setState(() {
        _ordonnancesFuture = _ordonnanceservice.getOrdonnancesBySpecialite(widget.specialite);
      });
    } catch (e) {
      print('Error during deletion of ordonnance: $e');
    }
  }


  Widget _buildOrdonnanceItem(Ordonnance ordonnance) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 15),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              router.navigateTo(context, '/detailsord/${ordonnance.idOrd}');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.pageview,
                  color: Colors.red,
                ),
                // Add more icons or widgets as needed
              ],
            ),
          ),

          InkWell(


            child: Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ordonnance.photoOrdonnance != null
                      ? Image.asset(
                    //ordonnance.photoOrdonnance!,
                    "assets/images/img4.jpg",
                    height: 90,
                    width: 90,
                  )
                      : Container(),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/detailsord');
              },
              child: Text(
                ordonnance.nomMedcin,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF4C53A5),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => _deleteOrdonnance(ordonnance.idOrd),
                  child: Icon(
                    Icons.delete,
                    color: Colors.amber,
                  ),
                ),
    InkWell(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => ModifierOrdWidget(ordonnanceId: ordonnance.idOrd),
    ),
    ).then((value) {
    setState(() {
    _ordonnancesFuture = _ordonnanceservice.getOrdonnancesBySpecialite(widget.specialite);
    });
    });
    },
    child: Icon(
                    Icons.edit_rounded,
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
    return FutureBuilder<List<Ordonnance>>(
      future: _ordonnancesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No ordonnance found.'));
        } else {
          return GridView.count(
            childAspectRatio: 0.68,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            shrinkWrap: true,
            children: [
              for (int i = 0; i < snapshot.data!.length; i++)
                _buildOrdonnanceItem(snapshot.data![i]),
            ],
          );
        }
      },
    );
  }
}
