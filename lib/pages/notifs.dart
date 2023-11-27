import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:minipharma/Models/Rappel.dart';
import 'package:minipharma/Models/themes.dart';
import 'package:minipharma/Services/NotifService.dart';
import 'package:minipharma/Services/notifications_services.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:minipharma/pages/AddHeure.dart';
import 'package:minipharma/pages/TaskTile.dart';

class NotifsWidget extends StatefulWidget {
  const NotifsWidget({Key? key}) : super(key: key);

  @override
  _NotifsWidgetState createState() => _NotifsWidgetState();
}

class _NotifsWidgetState extends State<NotifsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<MedicamentRappel>> _rappelsFuture;
  final NotifService _rappelService = NotifService();

  @override
  void initState() {
    super.initState();
    _rappelsFuture = _rappelService.getAllRappels();
  }

  void _refreshRappels() {
    setState(() {
      _rappelsFuture = _rappelService.getAllRappels();
    });
  }
  Future<void> _deleteRappel(int id) async {
    try {
      await _rappelService.deleteRappel(id);
      setState(() {
        _rappelsFuture = _rappelService.getAllRappels();
      });
    } catch (e) {
      print('Erreur lors de la suppression du médicament : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //datephrase
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMMd().format(DateTime.now()),
                        style: subHeadingStyle,
                      ),
                      Text("Today", style: HeadingStyle),
                    ],
                  ),
                ),
                //ajouterbtn
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddHeureWidget()),
                      );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    primary: Colors.blue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      "+ Ajouter \nheure \nrappel",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: primaryClr,
              selectedTextColor: Colors.white,
              dateTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 15),
          // Afficher les rappels sous la calendrier
          _showHeuresRappels(),
        ],
      ),
    );
  }

  _showHeuresRappels() {
    return Expanded(
      child: FutureBuilder<List<MedicamentRappel>>(
        future: _rappelsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun rappel trouvé.'));
          } else {
        return ListView.builder(
  itemCount: snapshot.data!.length,
  itemBuilder: (_, index) {
   MedicamentRappel rappel = snapshot.data![index];
//DateTime date = rappel.heureRappel; // Assume that rappel.heureRappel is already a DateTime object

/*var mytime = DateFormat("HH:mm").format(date);
NotificationServices().scheduleNotification(
  int.parse(mytime.toString().split((":")[0]) as String),
  int.parse(mytime.toString().split(":")[1]),
  rappel

  );*/
  

    //print("***********  ${mytime}   ************");
    return AnimationConfiguration.staggeredList(
      position: index,
       child: SlideAnimation(
        child:FadeInAnimation(
          child:Row(
            children: [
              GestureDetector(
                onTap: (){
                _ShowBottomSheet(context, rappel);
                   NotificationServices().showNotification(
              title: 'Sample title', body: 'It works!');
        
                },
                child: TaskTile(rappel),
              )

          ],)
          ),),);

          
    /*return Container(
      width: 100,
      height: 50,
      color: Colors.green,
      margin: const EdgeInsets.only(bottom: 10),
      child: Text(
        // Formatter la date ici
        DateFormat('HH:mm:ss').format(rappel.heureRappel),
        style: TextStyle(color: Colors.white),
      ),
    );*/
  },
);

          }
        },
      ),
    );
  }

_ShowBottomSheet(BuildContext context,MedicamentRappel medrap){
Get.bottomSheet(
  Container(
    padding : const  EdgeInsets.only(top:4),
height: medrap.isCompleted==1?
MediaQuery.of(context).size.height*0.24:
MediaQuery.of(context).size.height*0.32,
color:Get.isDarkMode?darkGreyClr:Colors.white,
child:Column(children: [
  Container(
    height: 6,
    width: 120,
    decoration:  BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300],
    ),
  ),
  Spacer(),
medrap.isCompleted==1
?Container()
: _bottomSheetButton(label: "Task completed", onTap: (){
  medrap.isCompleted==1;
  Get.back();
}, clr: primaryClr,
context:context,

),
SizedBox(
  height: 20,
),
_bottomSheetButton(label: "Delete task", onTap: (){
  _deleteRappel(medrap.id);
  Get.back();
}, clr: Colors.red[300]!,
context:context,

),
SizedBox(
  height: 20,
),
_bottomSheetButton(label: "Close", onTap: (){
  Get.back();
}, clr: Colors.red[300]!,
isClose: true,
context:context,

),
SizedBox(
  height: 20,
),
],)

),
);

}
_bottomSheetButton({
  required String label,
  required Function onTap,
  required Color clr,
  bool isClose=false,
  required BuildContext context,


}){
return GestureDetector(
  onTap:(){},
  child: Container(
    margin:  const EdgeInsets.symmetric(vertical: 4),
    height: 55,
    width: MediaQuery.of(context).size.width*0.9,
    decoration: BoxDecoration(
  
        border: Border.all(
          width: 2,
          color:isClose==true?Colors.red:clr
        ),
        borderRadius: BorderRadius.circular(20),
            color:isClose==true?Colors.transparent:clr,

      
    ),
    child: Center(child: 
    Text( label,
    style: isClose?titleStyle:titleStyle.copyWith(color:Colors.white),),)
    
  ),
);
}


  _appBar() {
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          print("button taped");
          NotificationServices().showNotification(
              title: 'Sample title', body: 'It works!');
        },
        child: Icon(Icons.nightlight_round, size: 20,
            color: Get.isDarkMode ? Colors.white : Colors.black),
      ),
      actions: [
        Icon(Icons.person, size: 20, color: Colors.black),
        SizedBox(width: 20),
      ],
    );
  }
}
