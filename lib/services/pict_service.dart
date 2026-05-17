import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pict_model.dart';

class PictService {
  static Future<List<PictModel>> getPictures() async {

    final response = await http.get(
      Uri.parse('https://picsum.photos/v2/list?page=2&limit=10'),
    );

    if (response.statusCode == 200) {

      List data = jsonDecode(response.body);

      return data.map((item) => PictModel.fromJson(item)).toList();

    } else {

      throw Exception("Gagal mengambil gambar");

    }
  }
}