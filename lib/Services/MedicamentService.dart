import 'dart:convert';
import 'package:dio/dio.dart';

import '../models/Medicament.dart';

class MedicamentService {
  final String baseUrl = "http://192.168.56.1:8077/medicament";
  Dio dio = Dio(BaseOptions(
    connectTimeout: 5000, // 5 seconds
    receiveTimeout: 3000, // 3 seconds
  ));



  Future<List<Medicament>> getAllMedicament() async {
    try {
      final response = await dio.get(baseUrl);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.data);
        List<Medicament> medicaments =
        data.map((item) => Medicament.fromJson(item)).toList();
        return medicaments;
      } else {
        print('Failed to load medicaments - ${response.statusCode}');
        print('Response body: ${response.data}');
        throw Exception('Failed to load medicaments');
      }
    } catch (e) {
      print('Error in getAllMedicaments: $e');
      throw Exception('Failed to load medicaments');
    }
  }

  Future<Medicament> getMedicamentById(int id) async {
    try {
      final response = await dio.get('$baseUrl/$id');

      if (response.statusCode == 200) {
        return Medicament.fromJson(json.decode(response.data));
      } else {
        throw Exception('Failed to load medicament');
      }
    } catch (e) {
      print('Error in getMedicamentById: $e');
      throw Exception('Failed to load medicament');
    }
  }

  Future<Medicament> createMedicament(Medicament med) async {
    try {
      final response = await dio.post(
        '$baseUrl/addmed',
        options: Options(contentType: 'application/json'),
        data: jsonEncode(med.toJson()),
      );

      if (response.statusCode == 201) {
        return Medicament.fromJson(json.decode(response.data));
      } else {
        throw Exception('Failed to create medicament');
      }
    } catch (e) {
      print('Error in createMedicament: $e');
      throw Exception('Failed to create medicament');
    }
  }

  Future<void> deleteMedicament(int id) async {
    try {
      final response = await dio.delete('$baseUrl/$id');

      if (response.statusCode != 200) {
        throw Exception('Failed to delete medicament');
      }
    } catch (e) {
      print('Error in deleteMedicament: $e');
      throw Exception('Failed to delete medicament');
    }
  }

  Future<Medicament> updateMedicament(int id, Medicament med) async {
    try {
      final response = await dio.put(
        '$baseUrl/$id',
        options: Options(contentType: 'application/json'),
        data: jsonEncode(med.toJson()),
      );

      if (response.statusCode == 200) {
        return Medicament.fromJson(json.decode(response.data));
      } else {
        throw Exception('Failed to update medicament');
      }
    } catch (e) {
      print('Error in updateMedicament: $e');
      throw Exception('Failed to update medicament');
    }
  }
}
