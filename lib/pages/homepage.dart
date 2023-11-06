

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:minipharma/pages/OnBoardingPage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'modelboarding.dart';



class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);


  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {


  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  final controller= LiquidController();
  int currentPage=0;

  @override
  Widget build(BuildContext context) {
final size=MediaQuery.of(context).size;



final pages =[

  OnBoardinPageWidget(model: OnBoardingModel(

    image:"assets/images/welcome1.jpg",
    title:"Rappelez vos doses, restez en forme!",
    subtitle:" Ne manquez jamais une dose avec notre application de rappel de médicaments, pour une gestion de santé sans souci.",

    counterText:"1/3",
    bgColor:Colors.white,
    height:size.height,


  ),),

  OnBoardinPageWidget(model: OnBoardingModel(

    image:"assets/images/homeimgnv1.png",
    title:"Votre santé entre vos mains !",
    subtitle:"Notre application de pharmacie maison vous offre une gestion simplifiée de votre stock de médicaments",

   counterText:"2/3",
    bgColor:Colors.white,
    //Color(0XFFFFCC80),
    height:size.height,


  ),),
  OnBoardinPageWidget(model: OnBoardingModel(

    image:"assets/images/welcome3.png",
    title:"Alerte d'expiration , Restez informé !",
    subtitle:"Soyez averti à temps sur les dates d'expiration de vos médicaments pour une gestion sécurisée et saine de votre pharmacie à domicile.",

    counterText:"3/3",
    bgColor:Colors.white,
    //Color(0xFFB0BEC5),
    height:size.height,


  ),),


];
    return GestureDetector(

      child: Scaffold(
        key: scaffoldKey,



body:
Stack(
  alignment: Alignment.center,
  children: [
  LiquidSwipe(
    pages: pages,

    slideIconWidget: Icon(Icons.arrow_back_ios),
  enableSideReveal: true,
    liquidController: controller,
  //  onPageChangeCallback: onPageChangeCallback,

),
    Positioned(
        bottom: 60.0,

        child:OutlinedButton(
          onPressed: (){
            int nextPage=controller.currentPage +1;
            controller.animateToPage(page: nextPage);
          },
          style: ElevatedButton.styleFrom(
          side:const BorderSide(color:Colors.black),
          shape:const CircleBorder(),
          padding:const EdgeInsets.all(15),
          onPrimary:Colors.white,
          ),
          child:
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Colors.black54,shape: BoxShape.circle),

            child: const Icon(Icons.arrow_forward_ios),
          ),
        )
    ),
    Positioned(
      top: 50,
      right: 20,
        child: TextButton(
      onPressed: ()=>controller.jumpToPage(page: 2),
          child: const Text("Skip",style:TextStyle(color:Colors.grey)),
    ),
    ),
    Positioned(
      top: 80,
      right: 30,
    child:ElevatedButton(

      style:ButtonStyle(
          minimumSize: MaterialStateProperty.all(Size(150, 50)),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),


              ))

      ),
      onPressed: () {Navigator.pushNamed(context, "/home2");
      print('Button pressed ...');
      },
      child: const Text('GET STARTED',style: TextStyle(
        color: Colors.black,// Définir la couleur du texte en rouge
      ),),



    ),
      ),
    Positioned(
        bottom: 10,
        child: AnimatedSmoothIndicator(
          count:3,
          activeIndex: controller.currentPage,
          effect: const WormEffect(
            activeDotColor:Color(0xff272727),
            dotHeight:5.0,
          ),

        ))


],)













       /* body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(5.00, 0.00),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Container(
                          width: double.infinity,
                          height: 500,
                          child: Stack(
                            children: [
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                                child: PageView(

                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        'assets/images/homeimgnv1.png',
                                        width: 60,
                                        height: 0,
                                        fit: BoxFit.cover,
                                        alignment: Alignment(0.00, 0.00),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        'assets/images/img5nv.png',
                                        width: 300,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        'assets/images/homeimg2nv.png',
                                        width: 300,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.00, 1.00),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 0, 16),

                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional(0.00, 0.00),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                          child: Text(
                            'Pharmacity',
                            style: TextStyle(

                              fontFamily: 'Roboto Mono',
                              fontSize: 40,
                              color: Colors.indigo,
                            ),
                          ),
                        ),
                        Text(
                          'Gérez votre pharmacie maison en toute \n simplicité avec Saydaliety!',
                          textAlign: TextAlign.center,
                          style:
                         TextStyle(
                            fontFamily: 'Readex Pro',
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                    child: ElevatedButton(

                      style:ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(150, 50)),
                          backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),


                              ))

                      ),
                      onPressed: () {Navigator.pushNamed(context, "/home2");
                        print('Button pressed ...');
                      },
                      child: const Text('GET STARTED',style: TextStyle(
                        color: Colors.white,// Définir la couleur du texte en rouge
                      ),),



                    ),
                  ),
                ],
              ),
            ],
          ),
        ), */
      ),
    );
  }

 /* void onPageChangeCallback(int activePageIndex) {
final controller=LiquidController();
RxInt currentPage=0.obs;

  }*/
}


