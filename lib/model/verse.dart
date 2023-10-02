class Verse {
  int? id;
  String numberInSurah;
  String numberInQuran;
  String textArab;
  String textLatin;
  String translationIndo;

  Verse({
    this.id,
    required this.numberInSurah,
    this.numberInQuran = "",
    required this.textArab,
    required this.textLatin,
    required this.translationIndo,
  });

  factory Verse.fromJson(Map<String, dynamic> json, String surahNumber) {
    return Verse(
      numberInSurah: json['nomor'],
      numberInQuran: "$surahNumber:" + json['nomor'],
      textArab: json['ar'],
      textLatin: json['tr'],
      translationIndo: json['id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'numberInSurah': this.numberInSurah,
      // 'numberInQuran': this.numberInQuran,
      'textArab': this.textArab,
      'textLatin': this.textLatin,
      'translationIndo': this.translationIndo,
    };
  }
}
