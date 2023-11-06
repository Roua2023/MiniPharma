import 'package:flutter/material.dart';

class ListMedAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(25),
      child: Row(children: [
        Icon(
          Icons.sort,
          size: 35,
          color: Color(0xFF4C53A5),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "Medicaments",
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
              Icons.medical_information,
              size: 35,
              color: Color(0xFF4C53A5),
            ),
          ),
        ),
      ]),
    );
  }
}