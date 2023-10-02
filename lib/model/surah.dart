class Surah {
  String number;
  String nameArab;
  String nameIndo;
  String translation;
  int numberOfVerses;
  String preBismillah = "بِسْمِ ٱللّٰهِ ٱلرَّحْمٰنِ ٱلرَّحِيمِ";
  String revelation;

  Surah({
    required this.number,
    required this.nameArab,
    required this.nameIndo,
    required this.translation,
    required this.numberOfVerses,
    required this.revelation,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      number: json['nomor'],
      nameArab: json['asma'],
      nameIndo: json['nama'],
      translation: json["arti"],
      numberOfVerses: json['ayat'],
      revelation: json['type'],
    );
  }

  Map<String, dynamic> toMap() => {
        'nomor': this.number,
        'asma': this.nameArab,
        'nama': this.nameIndo,
        'arti': this.translation,
        'ayat': this.numberOfVerses,
        'preBismillah': "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
        'type': this.revelation
      };
}
