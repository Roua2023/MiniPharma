import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
const Color bluishClr= Color(0xFF4e5ae8) ;
const Color yellowClr= Color(0xFFFFB746) ;
const Color pinkClr= Color(0xFFff4667) ;
const Color white= Colors.white ;
const Color primaryClr= bluishClr ;
const Color darkGreyClr= Color(0xFF121212) ;
const Color darkHeader= Color(0xFF424242) ;






class Themes{



  static final light= ThemeData(
    backgroundColor: Colors.white,
     primaryColor :Color(0xFF4e5ae8),
       brightness: Brightness.light,

      );
     static final dark= ThemeData(
      primaryColor: darkGreyClr,
      brightness: Brightness.light,
       );

}

TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode?Colors.grey[400]:Colors.grey)
  );
}
TextStyle get HeadingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode?Colors.white:Colors.black)
  );
}
 TextStyle get titleStyle{
    return GoogleFonts.lato(
      textStyle:TextStyle(
fontSize: 16,
fontWeight: FontWeight.w400,
color: Get.isDarkMode?Colors.white:Colors.black
      ),

    );
  }