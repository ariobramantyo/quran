import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quran/model/hadist.dart';
import 'package:quran/model/list_surah.dart';
import 'package:quran/model/spesific_surah.dart';
import 'package:quran/model/surah.dart';

class ApiService {
  static Future<List<Surah>> getSurah() async {
    Uri url = Uri.parse(
        'https://islamic-api-indonesia.herokuapp.com/api/data/json/quran');

    var response = await http.get(url);

    List<dynamic> data = jsonDecode(response.body)['result']['data'];

    List<Surah> listSurah = data.map<Surah>((e) => Surah.fromJson(e)).toList();

    return listSurah;
  }

  static Future<List<ListSurah>> getListSurah() async {
    Uri url = Uri.parse('https://api.quran.sutanlab.id/surah');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['data'];

        List<ListSurah> listSurah =
            data.map((json) => ListSurah.fromJson(json)).toList();

        return listSurah;
      } else {
        return List<ListSurah>.empty();
      }
    } catch (e) {
      print(e.toString());
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

  static Future<List<HadistBook>> getHadistsBook() async {
    Uri url = Uri.parse('https://api.hadith.sutanlab.id/books');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];

      List<HadistBook> hadist =
          data.map((data) => HadistBook.fromJson(data)).toList();

      return hadist;
    } else {
      return List<HadistBook>.empty();
    }
  }

  static Future<HadistsFromAuthor?> getHadistByAuthor(String name) async {
    Uri url =
        Uri.parse('https://api.hadith.sutanlab.id/books/$name?range=1-15');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body)['data'];

      HadistsFromAuthor hadistsFromAuthor = HadistsFromAuthor.fromJson(data);

      return hadistsFromAuthor;
    } else {
      return null;
    }
  }
}
