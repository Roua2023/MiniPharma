import 'dart:convert';

import 'package:minipharma/Models/Rappel.dart';
import 'package:http/http.dart' as http;

class NotifService{


Future<List<MedicamentRappel>> getAllRappels() async {
    try {
    
      final response = await http.get(Uri.parse('http://192.168.1.42:9098/rappels'));

    
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<MedicamentRappel> rappels =
            data.map((item) => MedicamentRappel.fromJson(item)).toList();
            
        return rappels;
      } else {
        print('Failed to load Rappels - ${response.statusCode}');
  print('Response body: ${response.body}');  // Ajout de cette ligne
  throw Exception('Failed to load Rappels');
      }
    } catch (e) {
      print('Error in getAllRappels: $e');
      throw Exception('Failed to load Rappels');
    }
  }
  
 Future<MedicamentRappel> createRappel(MedicamentRappel rap) async {
  try {
    final response = await http.post(
      Uri.parse('http://192.168.1.42:9098/rappels/addrappel'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(rap.toJson()),
    );

    if (response.statusCode == 201) {
      print("Il y a création du rappel");
      return MedicamentRappel.fromJson(json.decode(response.body));
    } else {
      print("Échec de la création du rappel");
      throw Exception('Failed to create rappel');
    }
  } catch (e) {
    print("Erreur lors de la création du rappel: $e");
    throw e;
  }
}

  Future<void> deleteRappel(int id) async {
    final response = await http.delete(Uri.parse('http://192.168.1.42:9098/rappels/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete rappel');
    }
  }

  Future<MedicamentRappel> updateRappel(int id, MedicamentRappel rap) async {
  

  final response = await http.put(
    Uri.parse('http://192.168.1.42:9098/rappels/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(rap.toJson()),
  );

  if (response.statusCode == 200) {
    return MedicamentRappel.fromJson(json.decode(response.body));
  } else {
    throw Exception('Échec de la mise à jour du rappel');
  }
}



}