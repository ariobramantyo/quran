class SpesificSurah {
  int number;
  int numberOfVerses;
  String nameIndo;
  String translation;
  String revelation;
  String preBismillah;
  List<Verse> verses;

  SpesificSurah({
    required this.number,
    required this.numberOfVerses,
    required this.nameIndo,
    required this.translation,
    required this.revelation,
    required this.preBismillah,
    required this.verses,
  });

  factory SpesificSurah.fromJson(Map<String, dynamic> json) {
    return SpesificSurah(
      number: json['number'],
      numberOfVerses: json['numberOfVerses'],
      nameIndo: json['name']['transliteration']['id'],
      translation: json['name']['translation']['id'],
      revelation: json['revelation']['id'],
      preBismillah: (json['number'] != 1)
          ? json['preBismillah']['text']['arab']
          : 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
      verses:
          json['verses'].map<Verse>((verse) => Verse.fromJson(verse)).toList(),
    );
  }
}

class Verse {
  int number;
  String textArab;
  String textLatin;
  String translationIndo;

  Verse({
    required this.number,
    required this.textArab,
    required this.textLatin,
    required this.translationIndo,
  });

  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      number: json['number']['inSurah'],
      textArab: json['text']['arab'],
      textLatin: json['text']['transliteration']['en'],
      translationIndo: json['translation']['id'],
    );
  }
}
