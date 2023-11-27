import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:minipharma/Models/diagnostic.dart';

class DiagnosticService{
   final String baseUrl = "http://192.168.1.43:9098/diagnostic";

   Future<List<Diagnostic>> getAllMedicament() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.1.43:9098/medicament'));

      //final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Diagnostic> medicaments =
            data.map((item) => Diagnostic.fromJson(item)).toList();
        return medicaments;
      } else {
        print('Failed to load medicaments - ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load medicaments');
      }
    } catch (e) {
      print('Error in getAllMedicaments: $e');
      throw Exception('Failed to load medicaments');
    }
  }

  Future<Diagnostic> getById(int id) async {
    final response =
        await http.get(Uri.parse('http://192.168.1.43:9098/medicament/$id'));

    if (response.statusCode == 200) {
      return Diagnostic.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load medicament');
    }
  }

  Future<Diagnostic> createDiagnostic(Diagnostic diag) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.43:9098/diagnostic/add'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(diag.toJson()),
    );

    if (response.statusCode == 201) {
      return Diagnostic.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create medicament');
    }
  }

  Future<void> deleteDiagnostic(int id) async {
    final response =
        await http.delete(Uri.parse('http://192.168.1.43:9098/medicament/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete medicament');
    }
  }

  Future<Diagnostic> updateDiagnostic(int id, Diagnostic diag) async {
    final response = await http.put(
      Uri.parse('http://192.168.1.43:9098/diagnostic/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(diag.toJson()),
    );

    if (response.statusCode == 200) {
      return Diagnostic.fromJson(json.decode(response.body));
     } else {
      throw Exception('Échec de la mise à jour du médicament');
    }
  }

}