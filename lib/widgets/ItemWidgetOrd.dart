
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:minipharma/Services/OrdonnanceService.dart';
import '../main.dart';
import '../models/Ordonnance.dart';
import '../pages/ModifierOrd.dart';

class ItemWidgetOrd extends StatefulWidget {
  final String specialite;

  const ItemWidgetOrd({Key? key, required this.specialite}) : super(key: key);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidgetOrd> {
  late Future<List<Ordonnance>> _ordonnancesFuture;
  final OrdonnanceService _ordonnanceService = OrdonnanceService();
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshOrdonnances();
  }

  Future<void> _deleteOrdonnance(int id) async {
    try {
      await _ordonnanceService.deleteOrdonnance(id);
      _refreshOrdonnances();
    } catch (e) {
      print('Error during deletion of ordonnance: $e');
    }
  }

  void _refreshOrdonnances() {
    setState(() {
      _ordonnancesFuture = _ordonnanceService.getOrdonnancesBySpecialite(widget.specialite);
    });
  }
  void _searchOrdonnances(String value) {
    setState(() {
      if (value.isEmpty) {
        // If the search value is empty, show all ordonnances
        _refreshOrdonnances();
      } else {
        // Filter ordonnances based on the search value
        _ordonnancesFuture = _ordonnanceService.getOrdonnancesBySpecialite(widget.specialite)
            .then((ordonnances) {
          return ordonnances.where((ordonnance) {
            // Customize this condition based on your filtering criteria
            String lowercaseValue = value.toLowerCase();
            return
              ordonnance.nomMedcin.toLowerCase().startsWith(lowercaseValue);
          }).toList();
        });
      }
    });
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
                      ? Image.file(
                File(ordonnance.photoOrdonnance!),
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
                        builder: (context) => ModifierOrdWidget(
                          ordonnanceId: ordonnance.idOrd,
                        ),
                      ),
                    ).then((value) {
                      _refreshOrdonnances();
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
    return Column(
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
                child: TextField(
                  controller: _searchController,
                  onChanged: _searchOrdonnances,
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
        FutureBuilder<List<Ordonnance>>(
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
        ),
      ],
    );
  }
}