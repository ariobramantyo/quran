class BookmarkHadist {
  int? id;
  String idName;
  int number;
  String name;

  BookmarkHadist({
    this.id,
    required this.idName,
    required this.number,
    required this.name,
  });

  factory BookmarkHadist.fromMap(Map<String, dynamic> map) {
    return BookmarkHadist(
        id: map['id'],
        idName: map['idName'],
        number: map['number'],
        name: map['name']);
  }

  Map<String, dynamic> toMap() => {
        'id': this.id,
        'idName': this.idName,
        'number': this.number,
        'name': this.name,
      };
}
