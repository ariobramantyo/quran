class ListSurah {
  int number;
  String nameArab;
  String nameIndo;
  int numberOfVerses;
  String revelation;

  ListSurah({
    required this.number,
    required this.nameArab,
    required this.nameIndo,
    required this.numberOfVerses,
    required this.revelation,
  });

  factory ListSurah.fromJson(Map<String, dynamic> json) {
    return ListSurah(
      number: json['number'],
      nameArab: json['name']['short'],
      nameIndo: json['name']['transliteration']['id'],
      numberOfVerses: json['numberOfVerses'],
      revelation: json['revelation']['id'],
    );
  }
}
