import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:minipharma/models/Ordonnance.dart';

final Dio dio = Dio();

class OrdonnanceService {
  Dio dio = Dio(BaseOptions(
    connectTimeout: 5000, // 5 seconds
    receiveTimeout: 3000, // 3 seconds
  ));
  final String baseUrl = "http://192.168.56.1:8077/ords";

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

  Future<Ordonnance> createOrdonnance(Ordonnance ord) async {
    final response = await dio.post(
      '$baseUrl/addord',
      options: Options(headers: {
        'Content-Type': 'application/json',
      }),
      data: jsonEncode(ord.toJson()),
    );

    if (response.statusCode == 201) {
      return Ordonnance.fromJson(response.data);
    } else {
      throw Exception('Failed to create ordonnance');
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
