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

  final controller = LiquidController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final pages = [
      OnBoardinPageWidget(
        model: OnBoardingModel(
          image: "assets/images/welcome1.jpg",
          title: "Rappelez vos doses, restez en forme!\n",
          subtitle:
              "        Ne manquez jamais une dose avec\n notre application de rappel de médicaments,\n       pour une gestion de santé sans souci.",
          counterText: "1-3",
          bgColor: Colors.white,
          height: size.height,
        ),
      ),
      OnBoardinPageWidget(
        model: OnBoardingModel(
          image: "assets/images/homeimgnv1.png",
          title: "Votre santé entre vos mains !\n",
          subtitle:
              "          Notre application de pharmacie \n    maison vous offre une gestion simplifiée \n            de votre stock de médicaments",

          counterText: "2-3",
          bgColor: Colors.white,
          //Color(0XFFFFCC80),
          height: size.height,
        ),
      ),
      OnBoardinPageWidget(
        model: OnBoardingModel(
          image: "assets/images/alerte.png",
          title: "Alerte d'expiration , Restez informé !\n",
          subtitle:
              "   Soyez averti à temps sur les dates d'expiration\n de vos médicaments pour une gestion sécurisée\n       et saine de votre pharmacie à domicile.",

          counterText: "3-3",
          bgColor: Colors.white,
          //Color(0xFFB0BEC5),
          height: size.height,
        ),
      ),
    ];

    return GestureDetector(
      child: Scaffold(
          key: scaffoldKey,
          body: Stack(
            alignment: Alignment.center,
            children: [
              LiquidSwipe(
                pages: pages,

                // slideIconWidget: Icon(Icons.arrow_back_ios),
                // enableSideReveal: true,
                // liquidController: controller,
                //  onPageChangeCallback: onPageChangeCallback,
              ),
              Positioned(
                top: 50,
                right: 20,
                child: OutlinedButton(
                  onPressed: () {
                    int nextPage = controller.currentPage + 1;
                    controller.animateToPage(page: nextPage);
                  },
                  // style: ElevatedButton.styleFrom(
                  //    side: const BorderSide(color: Colors.black),
                  //    shape: const CircleBorder(),
                  //    padding: const EdgeInsets.all(15),
                  //   onPrimary: Colors.white,
                  // ),
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    child: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),

              // Positioned(
              //   top: 50,
              //   right: 20,
              //   child: TextButton(
              //     onPressed: () => controller.jumpToPage(page: 2),
              //     child:
              //         const Text("Skip", style: TextStyle(color: Colors.grey)),
              //   ),
              // ),

              Positioned(
                bottom: 100.0,
                child: ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(200, 50)),
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 212, 52, 52)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ))),
                  onPressed: () {
                    Navigator.pushNamed(context, "/home2");
                    print('Button pressed ...');
                  },
                  child: const Text(
                    'GET STARTED',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              // Positioned(
              //     bottom: 170,
              //     child: AnimatedSmoothIndicator(
              //       count: 3,
              //       activeIndex: controller.currentPage,
              //       effect: const WormEffect(
              //         activeDotColor: Color.fromARGB(255, 58, 16, 209),
              //         dotHeight: 5.0,
              //       ),
              //     ))
            ],
          )

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
