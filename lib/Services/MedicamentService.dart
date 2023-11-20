import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:minipharma/models/Medicament.dart';
//import 'package:dio/dio.dart';


class MedicamentService {
   String baseUrl = "http://192.168.1.109:9098/medicaments";
  //Dio _dio = Dio();
Future<List<Medicament>> getAllMedicaments() async {
    try {
    
      final response = await http.get(Uri.parse(baseUrl));

    
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Medicament> medicaments =
            data.map((item) => Medicament.fromJson(item)).toList();
            
        return medicaments;
      } else {
        print('Failed to load medicaments - ${response.statusCode}');
  print('Response body: ${response.body}');  // Ajout de cette ligne
  throw Exception('Failed to load medicaments');
      }
    } catch (e) {
      print('Error in getAllMedicaments: $e');
      throw Exception('Failed to load medicaments');
    }
  }
  

 Future<String> uploadFile(File file) async {
  try {
    if (file.existsSync()) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.1.109:9098/upload'),
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


   /*Future<Response<dynamic>> uploadFile(File file) async {
    try {
      String baseUrl = 'http://192.168.1.36:9098/medicaments/upload';
      
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path,
          filename: 'image.jpg',
        ),
      });

      return await _dio.post(baseUrl, data: formData);
      
    } catch (e) {
      print('Error uploading file: $e');
      throw e;
    }
  }*/

 
/*Future<http.Response> uploadFile(File file) async {
  var request = http.MultipartRequest(
      'POST', Uri.parse('http://192.168.1.36:9098/medicaments/upload'));

  // Set the correct Content-Type
  request.headers['Content-Type'] = 'multipart/form-data';

  request.files.add(await http.MultipartFile.fromPath('file', file.path));

  var streamedResponse = await request.send();
  return await http.Response.fromStream(streamedResponse);
}

 */
  /* Future<String> uploadImage(File image) async {
    try {
      final uri = Uri.parse('$baseUrl/upload');
      final request = http.MultipartRequest('POST', uri);
      request.files.add(  await http.MultipartFile.fromBytes(
        'image',
        await image.readAsBytes(),
        filename: 'image.jpg',
      ));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        return responseBody;
      } else {
        throw Exception('Échec de l\'envoi de l\'image. Statut : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur lors de l\'envoi de l\'image : $e');
    }
  }*/

 
  /*Future<List<Medicament>> getAllMedicaments() async {
    try {
    
      final response = await http.get(Uri.parse('http://192.168.1.41:9096/medicament'));

      

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Medicament> medicaments =
        
            data.map((item) => Medicament.fromJson(item)).toList();

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
  }*/
 Future<Medicament> getMedicamentById(int id) async {
    final response = await http.get(Uri.parse('http://192.168.1.109:9098/medicaments/$id'));
    
    if (response.statusCode == 200) {
      return Medicament.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load medicament');
    }
  }

  Future<Medicament> createMedicament(Medicament med) async {
  try {
    final response = await http.post(
      Uri.parse('http://192.168.1.109:9098/medicaments/addmed'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(med.toJson()),
    );

    if (response.statusCode == 201) {
      print("Il y a création du médicament");
      return Medicament.fromJson(json.decode(response.body));
    } else {
      print("Échec de la création du médicament");
      throw Exception('Failed to create medicament');
    }
  } catch (e) {
    print("Erreur lors de la création du médicament: $e");
    throw e;
  }
}

  Future<void> deleteMedicament(int id) async {
    final response = await http.delete(Uri.parse('http://192.168.1.109:9098/medicaments/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete medicament');
    }
  }

  Future<Medicament> updateMedicament(int id, Medicament med) async {
  

  final response = await http.put(
    Uri.parse('http://192.168.1.109:9098/medicaments/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(med.toJson()),
  );

  if (response.statusCode == 200) {
    return Medicament.fromJson(json.decode(response.body));
  } else {
    throw Exception('Échec de la mise à jour du médicament');
  }
}

}
