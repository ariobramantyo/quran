class HadistBook {
  String name;
  String id;

  HadistBook({
    required this.name,
    required this.id,
  });

  factory HadistBook.fromJson(Map<String, dynamic> json) {
    return HadistBook(name: json['name'], id: json['id']);
  }
}

class HadistsFromAuthor {
  String id;
  String name;
  List<Hadist> hadiths;

  HadistsFromAuthor({
    required this.id,
    required this.name,
    required this.hadiths,
  });

  factory HadistsFromAuthor.fromJson(Map<String, dynamic> json) {
    return HadistsFromAuthor(
      id: json['id'],
      name: json['name'],
      hadiths:
          json['hadiths'].map<Hadist>((json) => Hadist.fromJson(json)).toList(),
    );
  }
}

class Hadist {
  int number;
  String arab;
  String indo;

  Hadist({
    required this.number,
    required this.arab,
    required this.indo,
  });

  factory Hadist.fromJson(Map<String, dynamic> json) {
    return Hadist(number: json['number'], arab: json['arab'], indo: json['id']);
  }
}
