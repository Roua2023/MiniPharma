import 'dart:convert';
import 'dart:io';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:minipharma/models/Ordonnance.dart';
import 'package:http/http.dart' as http;


final Dio dio = Dio();

class OrdonnanceService {
  Dio dio = Dio(BaseOptions(
    connectTimeout: 5000, // 5 seconds
    receiveTimeout: 3000, // 3 seconds
  ));
  final String baseUrl = "http://192.168.180.184:9098/ords";

  Future<List<Ordonnance>> getAllOrdonnances() async {
    try {
      final response = await dio.get('$baseUrl');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        if (data != null) {
          List<Ordonnance> ordonnances =
          data.map((item) => Ordonnance.fromJson(item)).toList();
          return ordonnances;
        } else {
          print('Data is null');
          return [];
        }
      } else {
        print('Failed to load Ordonnances - ${response.statusCode}');
        print('Response body: ${response.data}');
        throw Exception('Failed to load Ordonnances');
      }
    } catch (e) {
      print('Error in getAllOrdonnances: $e');
      throw Exception('Failed to load Ordonnances');
    }
  }
  Future<List<Ordonnance>> getOrdonnancesBySpecialite(String specialite) async {
    try {
      final response = await dio.get('$baseUrl/$specialite');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        if (data != null) {
          List<Ordonnance> ordonnances =
          data.map((item) => Ordonnance.fromJson(item)).toList();
          return ordonnances;
        } else {
          // Handle the case where 'data' is null
          print('Data is null');
          return []; // or throw an exception, depending on your use case
        }
      } else {
        print('Failed to load Ordonnances - ${response.statusCode}');
        print('Response body: ${response.data}');
        throw Exception('Failed to load Ordonnances');
      }
    } catch (e) {
      print('Error in getOrdonnancesBySpecialite: $e');
      throw Exception('Failed to load Ordonnances');
    }
  }


  Future<Ordonnance> getOrdonnanceById(int id) async {
    final response = await dio.get('$baseUrl/get/$id');

    if (response.statusCode == 200) {
      return Ordonnance.fromJson(response.data);
    } else {
      throw Exception('Failed to load ordonnance');
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

  Future<Ordonnance> createOrdonnance(Ordonnance ord) async {
    try {
    final response = await http.post(
      Uri.parse('$baseUrl/addord'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(ord.toJson()),
    );
      

    if (response.statusCode == 201) {
      print("Il y a création du ordonnance");
      return Ordonnance.fromJson(json.decode(response.body));
    } else {
      print("Échec de la création du médicament");
      throw Exception('Failed to create ordonnance');
    }
  } catch (e) {
    print("Erreur lors de la création du ordonnance: $e");
    throw e;
  }
  }










  Future<void> deleteOrdonnance(int id) async {
    final response = await dio.delete('$baseUrl/delete/$id');

    if (response.statusCode != 200) {
      throw Exception('Failed to delete ordonnance');
    }
  }

  Future<Ordonnance> updateOrdonnance(int id, Ordonnance ord) async {
    final response = await dio.put(
      '$baseUrl/update/$id',
      options: Options(headers: {
        'Content-Type': 'application/json',
      }),
      data: jsonEncode(ord.toJson()),
    );

    if (response.statusCode == 200) {
      return Ordonnance.fromJson(response.data);
    } else {
      throw Exception('Failed to update ordonnance');
    }
  }
}