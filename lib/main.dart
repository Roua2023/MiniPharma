import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:minipharma/Models/themes.dart';
import 'package:minipharma/Services/notifications_services.dart';
import 'package:minipharma/pages/%20ListMed.dart';
import 'package:minipharma/pages/AddHeure.dart';
import 'package:minipharma/pages/AjouterDiagnostic.dart';
import 'package:minipharma/pages/AjouterMed.dart';
import 'package:minipharma/pages/AjouterOrd.dart';
import 'package:minipharma/pages/DetailsDiagnostic.dart';
import 'package:minipharma/pages/DetailsMedicament.dart';
import 'package:minipharma/pages/DetailsOrds.dart';
import 'package:minipharma/pages/ListDiagnostic.dart';
import 'package:minipharma/pages/ListOrd.dart';
import 'package:minipharma/pages/ModifierDiagnostic.dart';
import 'package:minipharma/pages/ModifierMedicament.dart';
//import 'package:minipharma/pages/ModifierOrd.dart';
import 'package:minipharma/pages/TypesOrdonnances.dart';
import 'package:minipharma/pages/homepage2.dart';
import 'package:minipharma/pages/notifs.dart';
import 'package:minipharma/pages/profile1.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'pages/homepage.dart';
final FluroRouter router = FluroRouter();

void defineRoutes() {
  router.define(
    "/",
    handler: Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
        return const MyHomePage(title: 'Flutter Demo Home Page');
      },
    ),
  );

 router.define(
    '/modifiermed',
    handler: Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
        return const ModifierMedicamentWidget();
      },
    ),
  );

  router.define(
    '/home2',
    handler: Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
        return const HomePage2Widget();
      },
    ),
  );

  router.define(
    '/profile',
    handler: Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
        return const Profile1Widget();
      },
    ),
  );
router.define(
    '/notifs',
    handler: Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
        return const Profile1Widget();
      },
    ),
  );
  // ... Ajoutez les autres routes ici

  router.define(
    '/detailsord/:id',
    handler: Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
        final int? ordonnanceId = int.tryParse(params['id']?[0] ?? '');
        return DetailsOrdonnances(ordonnanceId: ordonnanceId);
      },
    ),
  );
}


Future<void> main()  async{
 
  await GetStorage.init();
 WidgetsFlutterBinding.ensureInitialized();
 await NotificationServices().initNotification();
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {
        "/home2":(context)=>HomePage2Widget(),
        "/profile":(context)=>Profile1Widget(),
        "/notifs":(context)=>NotifsWidget(),
        "/ajoutermed":(context)=>AjouterMedWidget(),
        "/ajouterord":(context)=>AjouterOrdWidget(),
        "/listmed":  (context) =>  ListMed(),
        "/listord":(context)=>ListOrd(specialite: ""),
        "/detailsord": (context) => DetailsOrdonnances(),
        "/principale":(context)=>HomePageWidget(),
        '/medicamentdetail': (context) => DetailsMedicament(),
        '/typesord': (context) => TypesOrdonnances(),
         '/modifiermed':(context)=>ModifierMedicamentWidget(),
         '/listdiagnostic': (context) => DiagnosticListPage(),
        '/ajouterdiagnostic': (context) => AjouterDiagnostic(),
        '/detailsdiagnostic': (context) => DetailsDiagnostic(),
        '/modifierdiagnostic': (context) => ModifierDiagnostic(),
         '/Addrappel': (context) => AddHeureWidget(),


      },

      initialRoute: "/principale",
      debugShowCheckedModeBanner:false,
      theme: Themes.light,
     darkTheme: Themes.dark,
      themeMode: ThemeMode.dark,
     
    );

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
    
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
       
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
       
        title: Text(widget.title),
      ),
      body: Center(
        
        child: Column(
         
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
