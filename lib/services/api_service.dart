import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quran/model/hadist.dart';
import 'package:quran/model/surah.dart';
import 'package:quran/model/salah_time.dart';
import 'package:quran/model/verse.dart';

class ApiService {
  static Future<List<Surah>> getListSurah() async {
    // Uri url = Uri.parse('https://api.quran.sutanlab.id/surah');
    Uri url = Uri.parse('https://api.npoint.io/99c279bb173a6e28359c/data');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<Surah> listSurah =
            data.map((json) => Surah.fromJson(json)).toList();

        return listSurah;
      } else {
        return List<Surah>.empty();
      }
    } catch (e) {
      print(e.toString());
      return List<Surah>.empty();
    }
  }

  static Future<List<Verse?>> getSurahVerses(String id) async {
    // Uri url = Uri.parse('https://api.quran.sutanlab.id/surah/$id');
    Uri url = Uri.parse('https://api.npoint.io/99c279bb173a6e28359c/surat/$id');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<Verse> listSurahVerses =
            data.map((json) => Verse.fromJson(json, id)).toList();

        return listSurahVerses;
      } else {
        return List<Verse>.empty();
      }
    } catch (e) {
      print(e.toString());
      return List<Verse>.empty();
    }
  }

  static Future<List<HadistBook>> getHadistsBook() async {
    Uri url = Uri.parse('https://api.hadith.sutanlab.id/books');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['data'];

        List<HadistBook> hadist =
            data.map((data) => HadistBook.fromJson(data)).toList();

        return hadist;
      } else {
        return List<HadistBook>.empty();
      }
    } catch (e) {
      print(e.toString());
      return List<HadistBook>.empty();
    }
  }

  static Future<HadistsFromAuthor?> getHadistByAuthor(String name) async {
    Uri url =
        Uri.parse('https://api.hadith.sutanlab.id/books/$name?range=1-15');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body)['data'];

        HadistsFromAuthor hadistsFromAuthor = HadistsFromAuthor.fromJson(data);

        return hadistsFromAuthor;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<SalahTime?> getSalahTime(
      double longitude, double latitude) async {
    Uri url = Uri.parse(
        'https://api.pray.zone/v2/times/today.json?longitude=$longitude&latitude=$latitude');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['results']['datetime'];

        List<SalahTime> listSalahTime = data
            .map<SalahTime>((data) => SalahTime.fromJson(data['times']))
            .toList();

        return listSalahTime[0];
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
