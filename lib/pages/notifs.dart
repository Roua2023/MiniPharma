import 'package:flutter/material.dart';
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
      _refreshRappels();
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
          _buildHeader(),
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
          _showHeuresRappels(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDatePhrase(),
          _buildAddButton(),
        ],
      ),
    );
  }

  Widget _buildDatePhrase() {
    return Container(
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
    );
  }

  Widget _buildAddButton() {
    return ElevatedButton(
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
    );
  }

  Widget _showHeuresRappels() {
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
            return _buildRappelsList(snapshot.data!);
          }
        },
      ),
    );
  }

  Widget _buildRappelsList(List<MedicamentRappel> rappels) {
    return ListView.builder(
      itemCount: rappels.length,
      itemBuilder: (_, index) {
        MedicamentRappel rappel = rappels[index];
        return AnimationConfiguration.staggeredList(
          position: index,
          child: SlideAnimation(
            child: FadeInAnimation(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                     /* _showBottomSheet(context, rappel);
                      NotificationServices().showNotification(
                        title: 'Rappel d\'un medicament ',
                        body: 'Il est temps de prendre ce médicament !',
                      );*/
                    },
                    child: TaskTile(rappel),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

    // Existing code...

  void _showBottomSheet(BuildContext context, MedicamentRappel medrap) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: medrap.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.32,
        color: Get.isDarkMode ? darkGreyClr : Colors.white,
        child: ListView(
          children: [
            Container(
              height: 12,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
              ),
            ),
            Spacer(),
            medrap.isCompleted == 1
                ? Container()
                : _bottomSheetButton(
                    label: "Rappel completed",
                    onTap: () {
                      // Handle completion logic
                    },
                    clr: primaryClr,
                    context: context,
                  ),
            SizedBox(height: 15),
            _bottomSheetButton(
              label: "Delete Rappel",
              onTap: () {
                _deleteRappel(medrap.id);
              },
              clr: Colors.red[300]!,
              context: context,
            ),
            SizedBox(height: 15),
            _bottomSheetButton(
              label: "Close",
              onTap: () {
                Navigator.pop(context);
              },
              clr: Colors.red[300]!,
              isClose: true,
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomSheetButton({
    required String label,
    required Function onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose ? Colors.red : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose
                ? titleStyle
                : titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          print("button taped");
          NotificationServices().showNotification(
              title: 'Change Mode', body: 'Mode works!');
        },
        child: Icon(
          Icons.nightlight_round,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        Icon(Icons.person, size: 20, color: Colors.black),
        SizedBox(width: 20),
      ],
    );
  }
}




