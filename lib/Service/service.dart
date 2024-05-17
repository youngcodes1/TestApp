import 'dart:convert';

import 'package:test_app/Model/image_model.dart';
import 'package:http/http.dart' as http;

import '../Utils/api/api.dart';

class ImageService {
  static const String _baseUrl = 'https://api.unsplash.com';

  static Future<List<ImageModel>> fetchPhotos(
      {int page = 1, int perPage = 10}) async {
    final response = await http.get(
      Uri.parse(
          '$_baseUrl/photos?page=$page&per_page=$perPage&client_id=${Constants.apikey}'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => ImageModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
