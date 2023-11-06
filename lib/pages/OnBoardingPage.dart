import 'package:flutter/material.dart';

import 'modelboarding.dart';
class OnBoardinPageWidget extends StatelessWidget{

    const OnBoardinPageWidget({
     Key? key,
    required this.model,
    });

  final OnBoardingModel model;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      color:model.bgColor,
      child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //mainAxisSize: MainAxisSize.max,
        //crossAxisAlignment:CrossAxisAlignment.center ,
        children: [
          Image(
            image:AssetImage(
              model.image,
            ),height: model.height* 0.4,
          ),
    Align(
    alignment: AlignmentDirectional(0.00, 0.00),
    child:
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Text(model.title,style:TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
              Text(model.subtitle,
                  style:TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              )),
              Text(model.counterText),
              SizedBox(height: 80),
            ],
          ),
    ),

        ],

      ),);
  }






}