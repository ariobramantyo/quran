import 'package:quran/model/surah.dart';

class BookmarkVerse {
  int? id;
  final Surah surah;
  final String surahName;
  final String numberInQuran;
  final String surahNumber;
  final int numberOfVerseBookmarked;

  BookmarkVerse({
    this.id,
    required this.surah,
    required this.numberInQuran,
    required this.surahName,
    required this.surahNumber,
    required this.numberOfVerseBookmarked,
  });

  factory BookmarkVerse.fromMap(Map<String, dynamic> map) {
    return BookmarkVerse(
        id: map['id'],
        surah: Surah.fromJson(map["surah"]),
        surahName: map['surahName'],
        numberInQuran: map['numberInQuran'],
        surahNumber: map['surahNumber'],
        numberOfVerseBookmarked: map['numberOfVerseBookmarked']);
  }

  Map<String, dynamic> toMap() => {
        'id': this.id,
        'surah': this.surah.toMap(),
        'surahName': this.surahName,
        'numberInQuran': this.numberInQuran,
        'surahNumber': this.surahNumber,
        'numberOfVerseBookmarked': this.numberOfVerseBookmarked,
      };
}
