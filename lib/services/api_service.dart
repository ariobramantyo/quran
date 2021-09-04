import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quran/model/list_surah.dart';
import 'package:quran/model/spesific_surah.dart';

class ApiService {
  static Future<List<ListSurah>> getListSurah() async {
    Uri url = Uri.parse('https://api.quran.sutanlab.id/surah');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];

      List<ListSurah> listSurah =
          data.map((json) => ListSurah.fromJson(json)).toList();

      return listSurah;
    } else {
      return List<ListSurah>.empty();
    }
  }

  static Future<SpesificSurah?> getSpesificSurah(int id) async {
    Uri url = Uri.parse('https://api.quran.sutanlab.id/surah/$id');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(response.body)['data'] as Map<String, dynamic>;

      SpesificSurah surah = SpesificSurah.fromJson(data);

      return surah;
    } else {
      return null;
    }
  }
}
