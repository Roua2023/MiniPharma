import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/Bilan.dart';

class BilanService {
  String baseUrl = "http://192.168.180.184:9098/bilans";


  Future<List<Bilan>> getAllBilan() async {
    try {

      final response = await http.get(Uri.parse(baseUrl));


      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Bilan> Bilans =
        data.map((item) => Bilan.fromJson(item)).toList();

        return Bilans;
      } else {
        print('Failed to load Bilans - ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load Bilans');
      }
    } catch (e) {
      print('Error in getAllBilans: $e');
      throw Exception('Failed to load medicaments');
    }
  }
  Future<String> uploadFile(File file) async {
  try {
    if (file.existsSync()) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.180.184:9098/upload'),
      );

      request.files.add(http.MultipartFile.fromBytes(
        'file',
        await file.readAsBytes(),
        filename: 'image.jpg',
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print('here body : ${response.body}');

      if (response.statusCode == 200) {
        // Directly assign the response to imageUrl
        String imageUrl = response.body;
        print('Image URL: $imageUrl');
        return imageUrl;
      } else {
        throw Exception('Failed to upload image. Status: ${response.statusCode}');
      }
    } else {
      throw Exception('File does not exist.');
    }
  } catch (e) {
    print('Error uploading file: $e');
    throw e;
  }
}



  Future<Bilan> createBilan(Bilan Bil) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.180.184:9098/bilans/add'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(Bil.toJson()),
      );

      if (response.statusCode == 201) {
        print("Il y a création du Bilan");
        return Bilan.fromJson(json.decode(response.body));
      } else {
        print("Échec de la création du Bilan");
        throw Exception('Failed to create Bilan');
      }
    } catch (e) {
      print("Erreur lors de la création du Bilan: $e");
      throw e;
    }
  }



  Future<void> deleteBilan(int id) async {
    print('from service ${id}');
    final response = await http.delete(Uri.parse('http://192.168.180.184:9098/bilans/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete medicament');
    }
  }

  Future<Bilan> updateBilan(int id, Bilan bilan) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/bilans/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bilan.toJson()),
      );

      if (response.statusCode == 200) {
        return Bilan.fromJson(json.decode(response.body));
      } else {
        print('Failed to update bilan - ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to update bilan');
      }
    } catch (e) {
      print('Error in updateBilan: $e');
      throw Exception('Failed to update bilan');
    }
  }
}