import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:minipharma/widgets/ListDiagnosticAppBar.dart';

class Diagnostic {
  final String name;
  final String category;

  Diagnostic({
    required this.name,
    required this.category,
  });

 
}

final List<Diagnostic> diagnosticList = [
  Diagnostic(name: 'Hypertension artérielle (HTA) ', category: 'Clinique'),
  Diagnostic(name: 'Cancer du sein', category: 'Clinique'),
  Diagnostic(name: 'Anémie ferriprive', category: 'Laboratoire'),
];

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Diagnostic',
      debugShowCheckedModeBanner: false,
      home: DiagnosticListPage(),
    );
  }
}

class DiagnosticListPage extends StatefulWidget {
  const DiagnosticListPage({Key? key}) : super(key: key);

  @override
  State<DiagnosticListPage> createState() => _DiagnosticListPageState();
}

class _DiagnosticListPageState extends State<DiagnosticListPage> {
  final List<String> categories = ['Clinique', 'Laboratoire','Radiologique'];

  List<String> selectedCategories = [];

  List<Diagnostic> getFilteredDiagnostics() {
    return diagnosticList
        .where((diagnostic) =>
            selectedCategories.isEmpty ||
            selectedCategories.contains(diagnostic.category))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filterProducts = getFilteredDiagnostics();
    print(filterProducts);
    print(categories);
    print(diagnosticList);
    return Scaffold(
       
      body: Column(
        children: [
           ListDiagnosticAppBar(),
           
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5),
                  height: 50,
                  width: 260,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search here",
                    ),
                  ),
                ),
               
              ],
            ),
          ),

          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: categories
                  .map((category) => FilterChip(
                        selected: selectedCategories.contains(category),
                        label: Text(category),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              selectedCategories.add(category);
                            } else {
                              selectedCategories.remove(category);
                            }
                          });
                        },
                      ))
                  .toList(),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 30,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filterProducts.length,
              itemBuilder: (context, index) {
                final product = filterProducts[index];
                return Card(
                  elevation: 8.0,
                  margin: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(color: Color.fromARGB(255, 188, 143, 143)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      title: Text(
                        product.name,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        product.category,
                        style: const TextStyle(
                            color: Colors.white, fontStyle: FontStyle.italic),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, "/modifierdiagnostic");
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              //   Navigator.pushNamed(
                              //       context, "/ajouterdiagnostic");
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, "/detailsdiagnostic");
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: const Color(0xFFCB4354),
        items: const <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.notifications,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home2'); // Accueil
              break;
            case 1:
              Navigator.pushNamed(context, '/notifs'); // Notifications
              break;
            case 2:
              Navigator.pushNamed(context, '/profile'); // Profil
              break;
          }
        },
      ),
    );
  }
}
